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
    headers = self.find_header(doc)
    columns = self.get_headers(headers)
    rows = doc.xpath('//table[1]/tbody/tr')
    rows.each do |row|
      if row.children.first.text() =~ /\d{2}-\d{4}/
        statistic_attributes = []
        row.children.each_with_index do |child, index|
          value = child.text()
          if column_mapping = BlsColumnMapper.find_by_web_column_name(columns[index])
            if column_mapping.application_object != 'skip'
              if column_mapping.application_object == 'Occupation' && column_mapping.application_object_attribute == 'code'
                value = Occupation.convert_code(value)
              end
              statistic_attributes[index]={
                  'object': column_mapping.application_object,
                  'attribute': column_mapping.application_object_attribute,
                  'value': value
              }
            else
              os = OccupationalStatistic.new
              statistic_attributes.each do |statistic_attribute_set|
                os.send("#{statistic_attribute_set['object'].downcase}=", statistic_attribute_set['object'].constantize.where(statistic_attribute_set['attribute']: statistic_attribute_set['value'])
              end
              os.value=value
              os.year = self.year
              os.area = self.area
              os.save!
            end
          end
        end
      end
    end
    #get all rows of first table as xml
    #doc.xpath('//table[1]/tbody/tr')
    #get first row of first table as xml
    #header_hash =  self.get_headers(doc.xpath('//table[1]/thead/tr[1]'))
    #pp header_hash
    ##get the string value of the first cell of the first row
    #first_val = doc.xpath('//table[1]/tbody/tr[1]/td[1]/text()').to_s
    #print "\n \n first value of page #{self.source} for year #{year} is #{first_val} \n\n"
    #find the row that starts with 'Occupation Code' in the first cell

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

  def find_header (doc)
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
    return headers
  end

  def get_headers (header_row)
    heading_hash = Hash.new
    new_columns = Array.new
    header_row.each_with_index do |heading, index|
      unhashed_value = heading
      p "unhashed_value: #{unhashed_value}"
      value = unhashed_value.presence.downcase!
      p "value: #{value}"
      unless BlsColumnMapper.exists?(web_column_name: value)
        BlsColumnMapper.create!(web_column_name: value)
        new_columns.push value
      end
      heading_hash[index] = value
    end
    #if new_columns.count>0
    #  response =  "the following fields were added.  Go map them before continuing: \r\n"
    #  #debugger
    #  new_columns.each { |web_header| response << web_header << "\r\n"}
    #  raise response
    #end
    return heading_hash
  end

  def clean_area
end