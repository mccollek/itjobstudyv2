class BlsOesSpider
  require 'nokogiri'
  require 'open-uri'
  attr_reader :source_page, :candidate_pages
  def initialize args = {}
    @source_page = args.fetch(:source) do
      @source_page = 'http://www.bls.gov/oes/tables.htm'
    end
    @candidate_pages = []
  end

  def open_source
    Nokogiri::HTML(open(self.source_page))
  rescue  Errno::ENOENT
    false
  end

  def build_candidate_page_list
    self.reset_candidate_pages
    doc = self.open_source
    results = doc.xpath('//a[contains(text(), "HTML")]')
    results.each do |result|
      child_obj = BlsOesSpider.new(source: 'http://www.bls.gov' + result.attributes.first[1].value)
      print "looking at #{child_obj.source_page} \n"
      if child_obj.has_data?
        self.add_candidate(child_obj.source_page)
      else
        child_doc = child_obj.open_source
        state_list = child_doc.xpath('//blockquote/li/a')
        unless state_list.nil?
          child_path = Pathname.new(child_obj.source_page)
          state_dir = child_path.dirname.to_s
          state_list.each do |state_source|
            state_filename = state_source.first[1]
            state_page = BlsOesSpider.new(source: state_dir + '/' + state_filename)
            print "looking at #{state_page.source_page} \n"
            if state_page.has_data?
              self.add_candidate(state_page)
            end
          end
        end
      end
      print "we now have #{self.candidate_pages.count} candidate pages \n"
    end
  end

  def reset_candidate_pages
    @candidate_pages = []
  end

  def add_candidate(source)
    self.candidate_pages.push(source)
  end

  def has_data?
    #TODO: works for 2011-2013... have to fix with 2010
    doc = self.open_source

    if doc.xpath('//table[1]/tbody/tr[1]/td[1]/text()').present?
      print "#{self.source_page} has data\n"
      return true
    else
      print "#{self.source_page} does not have data\n"
      return false
    end
  end
end