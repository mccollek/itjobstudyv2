  require 'nokogiri'
  require 'open-uri'

  #get doc
  doc = Nokogiri::HTML(open('http://www.bls.gov/oes/2011/may/oes_nat.htm'))

#get all rows of first table as xml
doc.xpath('//table[1]/tbody/tr')

#get first row of first table as xml
header_hash =  this.get_headers(doc.xpath('//table[1]/tbody/tr[1]'))


pp header_hash

#get the string value of the first cell of the first row
doc.xpath('//table[1]/tbody/tr[1]/td[1]/text()').to_s

#TO-DO - make this extract the data
#national and state for each year is a separate URL.  Load the URLs from text file.  better, crawl http://www.bls.gov/oes/tables.htm for national state links
#TO-DO - lots of values have notes; what to do with each
#TO-DO - 2011 table differs from 2010 and before.  How can I read the table headers to figure out what column goes where?

def this.get_headers (header_row)
  heading_hash = Hash.new
  header_row.first.children.each_with_index do |heading, index|
    value = heading.children.first.text.strip!.presence
    heading_hash[index] = value
  end
end