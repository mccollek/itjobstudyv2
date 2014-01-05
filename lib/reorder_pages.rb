class ReorderPages
  def initialize
    statistic_pages = []
    resulting_pages = []
    File.open('lib/data/pages_file', 'r') {|f| statistic_pages = JSON.load(f)}
    statistic_pages.each do |statistic_page|
      if /nat/ =~ statistic_page['page_source']  || /sc/ =~ statistic_page['page_source']
        resulting_pages.push(statistic_page)
      end
    end
    File.open('lib/data/sc_file', 'w') {|f| JSON.dump(resulting_pages, f)}
  end
end

