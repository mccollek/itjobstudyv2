require 'csv'

desc "Import IT-oLogy IT Communications"
task :export_olo_columbia_data => [:environment] do
  data_file = 'lib/data/wiggins/data.csv'
  CSV.open(data_file, "wb") do |row|
    OccupationalStatistic.where(area_id: [1,584],
                              year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
                              data_type_id: [1,4],
                              period: ['S01', NIL],
                              industry_id: [1, NIL],
                              occupation_id: Report.last.occupations.to_a).each do |stat|
      row << [stat.year, stat.area.name, stat.occupation.code, stat.occupation.name, stat.data_type.name, stat.value]
    end
  end
end
