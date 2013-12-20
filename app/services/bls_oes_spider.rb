class BlsOesSpider
  require 'nokogiri'
  require 'open-uri'
  attr_reader :source_page
  def initialize args = {}
    @source_page = args.fetch(:source) do
      @source_page = 'http://www.bls.gov/oes/tables.htm'
    end
  end

  def open_source
    Nokogiri::HTML(open(self.source_page))
  rescue  Errno::ENOENT
    false
  end

  def build_candidate_page_list
    doc = self.open_source
    results = doc.xpath('//a[contains(text(), "HTML")]')
    candidate_pages = []
    results.each do |result|
      pp "result is #{result} \n"
      candidate_pages.push(result.attributes.first[1].value)
    end
    return candidate_pages
  end
end