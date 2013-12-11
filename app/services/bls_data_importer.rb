class BlsDataImporter
  require 'nokogiri'
  require 'open-uri'
  attr_reader :source
  def initialize attributes
    @source = attributes.fetch(:source)
    unless self.open_source
      raise ArgumentError, 'Sorry, the URL was not found'
      return false
    end
  end

  def import_data
    #get doc
    doc = self.open_source
    #get all rows of first table as xml
    doc.xpath('//table[1]/tbody/tr')

    #get first row of first table as xml
    header_hash =  this.get_headers(doc.xpath('//table[1]/tbody/tr[1]'))


    pp header_hash

    #get the string value of the first cell of the first row
    doc.xpath('//table[1]/tbody/tr[1]/td[1]/text()').to_s

  end

  def open_source
    Nokogiri::HTML(open(self.source))
  rescue  Errno::ENOENT
    false
  end

  def get_headers (header_row)
    heading_hash = Hash.new
    header_row.first.children.each_with_index do |heading, index|
      value = heading.children.first.text.strip!.presence
      heading_hash[index] = value
    end
  end
end