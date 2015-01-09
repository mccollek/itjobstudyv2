require 'csv'

desc "Export IT-oLogy Columbia Data"
task :export_olo_nc_data => [:environment] do
  data_file = 'lib/data/wiggins/nc_data.csv'
  CSV.open(data_file, "wb") do |row|
    OccupationalStatistic.where(area_id: [1, 552, 285,60],
                              year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013],
                              data_type_id: DataType.where(code: 1, data_category: 'OES').first.id,
                              period: ['S01', NIL],
                              industry_id: [1, NIL],
                              occupation_id: Report.last.occupations.to_a).each do |stat|
      puts "oes stat #{stat.occupation.name + ' ' + stat.year.to_s} for data type 1"
      row << [stat.year, stat.area.name, stat.occupation.code, stat.occupation.name, stat.data_type.name, stat.value, 'OES']
    end
    OccupationalStatistic.where(area_id: [1, 552, 285,60],
                              year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013],
                              data_type_id: DataType.where(code: 4, data_category: 'OES').first.id,
                              period: ['S01', NIL],
                              industry_id: [1, NIL],
                              occupation_id: Report.last.occupations.to_a).each do |stat|
      puts "oes stat #{stat.occupation.name + ' ' + stat.year.to_s} for data type 4"
      row << [stat.year, stat.area.name, stat.occupation.code, stat.occupation.name, stat.data_type.name, stat.value, 'OES']
    end
    OccupationalStatistic.where(area_id: [1, 552, 285,60],
                                year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013],
                                data_type_id: DataType.where(code:11, data_category: 'CES'),
                                period: 'M12',
                                industry_id: Report.last.industries.to_a).each do |stat|
      puts "ces stat #{stat.industry.name + ' ' + stat.year.to_s} for data type 11"
      row << [stat.year, stat.area.name, stat.industry.code, stat.industry.name, 'average annual wage', (stat.value*52).to_s, 'CES']
    end

    OccupationalStatistic.where(area_id: [1, 552, 285,60],
                                year: [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013],
                                data_type_id: DataType.where(code: 1, data_category: 'CES').first.id,
                                period: 'M12',
                                industry_id: Report.last.industries.to_a).each do |stat|
      puts "ces stat #{stat.industry.name + ' ' + stat.year.to_s} for data type 1"
      row << [stat.year, stat.area.name, stat.industry.code, stat.industry.name, 'employment', stat.value, 'CES']
    end
  end
end
