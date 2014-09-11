class BlsJsonDataImporter
require 'rest_client'
require 'json'
URL = 'http://api.bls.gov/publicAPI/v1/timeseries/data/'
  def initialize attributes
    @series_id = attributes.fetch(:series_id)
    #@series_id = 'OEUM000000000000000000001'
    @start_year = attributes.fetch(:start_year)
    @end_year = attributes.fetch(:end_year)

    unless BlsJsonDataImporter.test_source
      raise ArgumentError, "Sorry, cannot Access BLS JSON Data stream: #{self.test_source}"
      return false
    end
  end



  def query_bls
    payload = {'seriesid'=> [@series_id],
               'startyear'=> @start_year,
               'endyear'=> @end_year}.to_json
    Rails.logger.info(payload)
    JSON(RestClient.post(URL,
                         payload,
                         content_type: 'application/json'
         )
    )
  end

  def self.test_source
    result = JSON(RestClient.get("http://api.bls.gov/publicAPI/v1/timeseries/data/CFU0000008000"))
    if result['status'] == 'REQUEST_SUCCEEDED'
      return true
    else
      return result['status']
    end
  rescue  Errno::ENOENT
    false
  end

  def self.build_oe_series attributes
    @data_type = attributes.fetch(:data_type).code.to_s.rjust(2, "0")
    @area = attributes.fetch(:area)
    @area_code = attributes.fetch(:area).code.to_s.rjust(7, "0")
    @occupation = attributes.fetch(:occupation).code.to_s.rjust(6, "0")
    return ("OEU#{@area.area_type.code}#{@area_code}000000#{@occupation}#{@data_type}")
  end

end