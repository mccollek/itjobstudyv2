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

  def build_candidate_page_list args={}
    page_type = args.fetch(:type) do
      page_type = 'state'
    end
    if page_type == 'metro'
      page_parser = 'oessrcma'
      subpage_search = '//li/a'
      results_regex = /oes_\d/
    else
      page_parser = 'oessrcst'
      subpage_search = '//blockquote/li/a'
      results_regex = /oes_\w{2}\./
    end
    self.reset_candidate_pages
    doc = self.open_source
    #find all the links in the main page
    results = doc.xpath('//a[contains(text(), "HTML")]')
    #filter out the links based on page_type
    filtered_results = results.select {|r| r.attributes.first[1].value.include? page_parser}
    #look at each child page for valid grandchildren
    filtered_results.each do |result|
      high_level_url =  result.attributes.first[1].value
      if high_level_url.count('may')>0    #I don't want the november numbers, 2012 (already imported via csv) or anything before 2003
        child_obj = BlsOesSpider.new(source: 'http://www.bls.gov' + high_level_url)
        print "looking at #{child_obj.source_page} \n"
        if child_obj.has_data?
          self.add_candidate(child_obj.source_page)
        else
          child_doc = child_obj.open_source
          regions_list = child_doc.xpath(subpage_search)
          links = regions_list.map{|r| r.attributes.first[1].value}
          results = links.select {|r| r =~ results_regex }
          print "LINKS ARE: #{results}"
          #for states:
          #state_list = child_doc.xpath('//blockquote/li/a')
          #for metros :
          #state_list = child_doc.xpath('//td//ul/li/a')
          #bad hack for 2004 national data... going to ignore for now as has_data wouldn't work anyway
          #if child_obj.source_page = "http://www.bls.gov/oes/2004/may/oes_nat.htm"
            #  state_list = child_doc.xpath('//ul[preceding-sibling::p]/li/a')
          #end
          unless results.nil?
            child_path = Pathname.new(child_obj.source_page)
            state_dir = child_path.dirname.to_s
            results.each do |result|
              if result.count('/')>0
                state_url = 'http://www.bls.gov' + result
              else
                state_url = state_dir + '/' + result
              end
              state_page = BlsOesSpider.new(source: state_url)
              print "looking at lower level #{state_page.source_page} \n"
              if state_page.has_data?
                self.add_candidate(state_page.source_page)
              end
            end
          end
        end
        print "we now have #{self.candidate_pages.count} candidate pages \n"

      end
    end
    debugger
    return self.candidate_pages
  end

  def reset_candidate_pages
    @candidate_pages = []
  end

  def add_candidate(source)
    self.candidate_pages.push(source)
  end

  def has_data?

    doc = self.open_source

    if doc.at_xpath('//td[preceding-sibling::td[text()="00-0000"]]/text()').present?
    #if doc.at_xpath('//td//ul/li/a').present?
      print "#{self.source_page} has data\n"
      return true
    else
      print "#{self.source_page} does not have data\n"
      return false
    end
  end
end