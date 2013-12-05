require 'csv'

desc "Import Occupational Employment Data from txt file"
task :import => [:environment] do
  #unless Role.all.count > 0
  #  r = Role.create(name:'Admin')
  #  r.save
  #  r = Role.create(:name=>'User')
  #  r.save
  #end
  unless OccupationalStatistic.all.count > 0
    file = "lib/data/oe.data.0.Current"
    puts "Importing data"

    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      d = OccupationalStatistic.new
      series_id = row[0]
      puts "importing series id: #{series_id} \n"
      d.original_series = series_id
      d.area = Area.find_by_code(series_id[4..10])
      d.industry = Industry.find_by_code(series_id[11..16].gsub("-", "0").to_i)
      d.occupation = Occupation.find_by_code(series_id[17..22])
      d.data_type = DataType.find_by_code(series_id[23..24])
      d.year = row[1]
      d.period = row[2]
      d.value = row[3]
      d.save
    end
  end
end