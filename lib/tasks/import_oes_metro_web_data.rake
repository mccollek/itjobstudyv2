
desc "import data from 2011"

task :import_oes_metro_web_data => [:environment] do
  statistic_pages = []
  unless File.exists?('lib/data/pages_file')
    ##reference BlsDataImporter class to perform work
      bls_site = BlsOesSpider.new
      candidate_pages = bls_site.build_candidate_page_list(type: 'metro')
    candidate_pages.each do |page|
      directory_elements = page.split("/")
      data_year = directory_elements[4].to_i #leaves 'current_year' as 0, I've already imported 2012 and don't want it.
      data_month = directory_elements[5]
      if data_year > 2003 && data_month == 'may'  # I don't want November numbers
        p "page #{page} has a year of #{data_year}\n"
        statistic_pages.push(year: data_year, page_source: page)
      end
    end
    File.open('lib/data/pages_file', 'w') {|f| JSON.dump(statistic_pages, f)}
  else
    File.open('lib/data/pages_file', 'r') {|f| statistic_pages = JSON.load(f)}
  end
  #debugger
  statistic_pages.each do |statistic_page|
    stat_year = statistic_page[:year]  || statistic_page['year']
    page_source =  statistic_page[:page_source] || statistic_page["page_source"]
    print "\n\n statistic page to be looked at is: #{page_source} \n\n"
    page_to_parse = BlsDataImporter.new(source: page_source, year: stat_year)
    page_to_parse.import_data
  end


  #testing fodder
  #statistic_pages = []
  #statistic_pages.push(data_year: 2011, page_source: 'http://www.bls.gov/oes/2011/may/oes_nat.htm')
  #statistic_pages.push(data_year: 2010, page_source: 'http://www.bls.gov/oes/2010/may/oes_nat.htm')
  #statistic_pages.push(data_year: 2005, page_source: 'http://www.bls.gov/oes/2005/may/oes_nat.htm')
  #statistic_pages.push(data_year: 2005, page_source: 'http://www.bls.gov/oes/2005/may/oes_11500.htm')
  #statistic_pages.push(data_year: 2011, page_source: 'http://www.bls.gov/oes/2011/may/oes_ar.htm')
end


