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
    rows =  doc.xpath("//td[@class='main-content']//table//tr")
    rows.each do |row|
      pp "working on row #{row} \n"
      #debugger
      if row.children.first.text() =~ /\d{2}-\d{4}/
        statistic_attributes = []
        occ_value = ''
        row.xpath('child::*').each_with_index do |child, index|
          value = child.text()
          if column_mapping = BlsColumnMapper.find_by_web_column_name(columns[index])
            if column_mapping.application_object_attribute == 'name'
              if Occupation.where(code: occ_value).empty?
                #debugger
                Occupation.create(code: occ_value, name: value)
                p "created new occupation #{value} with code #{occ_value} \n"
              end
            end
            if column_mapping.application_object != 'skip'
              if column_mapping.application_object_attribute != 'value'
                if column_mapping.application_object == 'Occupation' && column_mapping.application_object_attribute == 'code'
                  value = Occupation.convert_code(value)
                  occ_value = value
                end
                statistic_attributes[index]={
                    stat_object: column_mapping.application_object,
                    stat_attribute: column_mapping.application_object_attribute,
                    stat_value: value }
              else
                data_type = column_mapping.data_type
                value_final = clean_value(value)
                p "about to check for a stat of type #{data_type.name} with value #{value_final} \n"


                os = OccupationalStatistic.find_or_initialize_by(data_type: data_type, value: value_final, year: self.year, area: self.area, occupation: Occupation.where(code: statistic_attributes[0][:stat_value]).first)
                if os.new_record?
                  statistic_attributes.each do |statistic_attribute_set|

                    os.send("#{statistic_attribute_set[:stat_object].downcase}=",
                            statistic_attribute_set[:stat_object].constantize.where(statistic_attribute_set[:stat_attribute].to_sym => statistic_attribute_set[:stat_value]).first)
                  end
                  p "about to save the following stat: \n"
                  pp os
                  #debugger
                  os.save!
                else
                  p "record of type #{data_type.name} with value #{value_final}  already exists \n"
                end
              end
            end
          end
        end
      end
    end
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

  def area
    uri = URI(self.source).to_s
    code = /_(\w+)\./.match(uri)[1]
    case code.length
      when 2
        area = Area.where(state: code.upcase).first
      when 3
        area = Area.find(1)
      when 5..7
        area = Area.where(code: code.to_i).first
      else
        raise("Can't find the area!!")
    end
    return area
  end

  def clean_value(value)
    value.gsub(",", "").gsub("%", "").gsub("$", "").to_f
  end
end