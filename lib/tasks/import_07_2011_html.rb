
desc "import data from 2011"

task :import => [:environment] do
  #reference BlsDataImporter class to perform work
  bls_site = BlsOesSpider.new
  candidate_pages = bls_site.build_candidate_page_list
  candidate_pages.each do |page|
    directory_elements = page.split("/")
    data_year = directory_elements[2].to_i #leaves 'current_year' as 0
    data_month = directory_elements[3]
    if data_year > 2002 && data_month == 'may'
      puts "page #{page} has a year of #{data_year}\n"
    end

  end
  BlsDataImporter.new(source: 'http://www.bls.gov/oes/2011/may/oes_nat.htm')
end


#TO-DO - make this extract the data
#national and state for each year is a separate URL.  Load the URLs from text file.  better, crawl http://www.bls.gov/oes/tables.htm for national state links
#TO-DO - lots of values have notes; what to do with each
#TO-DO - 2011 table differs from 2010 and before.  How can I read the table headers to figure out what column goes where?
