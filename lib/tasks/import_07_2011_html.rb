
desc "import data from 2011"

task :import => [:environment] do
  #reference BlsDataImporter class to perform work
  BlsDataImporter.new(source: 'http://www.bls.gov/oes/2011/may/oes_nat.htm')
end


#TO-DO - make this extract the data
#national and state for each year is a separate URL.  Load the URLs from text file.  better, crawl http://www.bls.gov/oes/tables.htm for national state links
#TO-DO - lots of values have notes; what to do with each
#TO-DO - 2011 table differs from 2010 and before.  How can I read the table headers to figure out what column goes where?
