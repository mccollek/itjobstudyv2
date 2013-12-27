class BlsDataImporter
  require 'nokogiri'
  require 'open-uri'
  attr_reader :source, :year
  def initialize attributes
    @source = attributes.fetch(:source)
    @year = attributes.fetch(:year)
    unless self.open_source
      raise ArgumentError, 'Sorry, the URL was not found'
      return false
    end
  end

  def import_data
    #get doc
    doc = self.open_source
    #get all rows of first table as xml
    #doc.xpath('//table[1]/tbody/tr')
    #get first row of first table as xml
    #header_hash =  self.get_headers(doc.xpath('//table[1]/thead/tr[1]'))
    #pp header_hash
    ##get the string value of the first cell of the first row
    #first_val = doc.xpath('//table[1]/tbody/tr[1]/td[1]/text()').to_s
    #print "\n \n first value of page #{self.source} for year #{year} is #{first_val} \n\n"
    #find the row that starts with 'Occupation Code' in the first cell
    header_string = doc.at_xpath('//tr[*[1][text()="Occupation Code"]]')  ||
        doc.at_xpath('//tr[*[1][text()="Occupation code"]]')
    print "found headers for #{self.source}: #{header_string} \n"
    headers = header_string.text().gsub(" ", "").split("\r\n")
    #remove empty values (saw some in 2005)
    headers.reject! {|header| header.empty?}
    #for each column, map text value to object_attribute in  occupational_statistics
    headers.each do |header|
      print "#{header} \n"
    end
    #for each subsequent row, if column[0] = '??-????'
      # eval column[0] to determine occupation
      # insert a row where
        # year = file year
        # period =  S01
  end

  def open_source
    Nokogiri::HTML(open(self.source))
  rescue  Errno::ENOENT
    false
  end

  def get_headers (header_row)
    heading_hash = Hash.new
    header_row.first.children.each_with_index do |heading, index|
      unhashed_value = heading.children.first
      pp "unhashed_value: #{unhashed_value}"
      value = unhashed_value.presence
      pp "value: #{value}"
      heading_hash[index] = value
    end
  end
end