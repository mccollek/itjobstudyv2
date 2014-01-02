
desc "import data from 2011"

task :import_bls => [:environment] do
  ##reference BlsDataImporter class to perform work
  bls_site = BlsOesSpider.new
  bls_site.build_candidate_page_list
  candidate_pages = bls_site.candidate_pages
  statistic_pages = []
  candidate_pages.each do |page|
    directory_elements = page.split("/")
    data_year = directory_elements[2].to_i #leaves 'current_year' as 0, I've already imported 2012 and don't want it.
    data_month = directory_elements[3]
    if data_year > 2003 && data_month == 'may'  # I don't want November numbers
      p "page #{page} has a year of #{data_year}\n"
      statistic_pages.push(year: data_year, page_source: "http://bls.gov"+page)
    end
  end
  #statistic_pages = []
  #statistic_pages.push(data_year: 2011, page_source: 'http://www.bls.gov/oes/2011/may/oes_nat.htm')
  #statistic_pages.push(data_year: 2010, page_source: 'http://www.bls.gov/oes/2010/may/oes_nat.htm')
  #statistic_pages.push(data_year: 2005, page_source: 'http://www.bls.gov/oes/2005/may/oes_nat.htm')
  #statistic_pages.push(data_year: 2005, page_source: 'http://www.bls.gov/oes/2005/may/oes_11500.htm')
  #statistic_pages.push(data_year: 2011, page_source: 'http://www.bls.gov/oes/2011/may/oes_ar.htm')

  statistic_pages.each do |statistic_page|
    print "\n\n statistic page to be looked at is: #{statistic_page[:page_source]} \n\n"
    page_to_parse = BlsDataImporter.new(source: statistic_page[:page_source], year: statistic_page[:data_year])
    page_to_parse.import_data
  end
end


