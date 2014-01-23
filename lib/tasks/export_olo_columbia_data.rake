require 'csv'

desc "Export IT-oLogy Columbia Data"
task :export_olo_columbia_data => [:environment] do
  data_file = 'lib/data/wiggins/data.csv'
  CSV.open(data_file, "wb") do |row|
    OccupationalStatistic.where(area_id: [1,584],
                              year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
                              data_type_id: DataType.where(code: 1, data_category: 'OES').first.id,
                              period: ['S01', NIL],
                              industry_id: [1, NIL],
                              occupation_id: Report.last.occupations.to_a).each do |stat|
      row << [stat.year, stat.area.name, stat.occupation.code, stat.occupation.name, stat.data_type.name, stat.value, 'OES']
    end
    OccupationalStatistic.where(area_id: [1,584],
                              year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
                              data_type_id: DataType.where(code: 4, data_category: 'OES').first.id,
                              period: ['S01', NIL],
                              industry_id: [1, NIL],
                              occupation_id: Report.last.occupations.to_a).each do |stat|
      row << [stat.year, stat.area.name, stat.occupation.code, stat.occupation.name, stat.data_type.name, stat.value, 'OES']
    end
    OccupationalStatistic.where(area_id: [1,584],
                                year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
                                data_type_id: DataType.where(code: 3, data_category: 'CES').first.id,
                                period: 'M09',
                                industry_id: Report.last.industries.to_a).each do |stat|
      puts "ces stat #{stat.industry.name + ' ' + stat.year}"
      row << [stat.year, stat.area.name, stat.industry.code, stat.industry.name, stat.data_type.name, stat.value*40*52, 'CES']
    end

    OccupationalStatistic.where(area_id: [1,584],
                                year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012],
                                data_type_id: DataType.where(code: 1, data_category: 'CES').first.id,
                                period: 'M09',
                                industry_id: Report.last.industries.to_a).each do |stat|
      row << [stat.year, stat.area.name, stat.industry.code, stat.industry.name, stat.data_type.name, stat.value, 'CES']
    end
  end
end
