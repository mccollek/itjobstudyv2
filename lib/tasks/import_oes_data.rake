require 'csv'

desc "Import Occupational Employment Data from txt file"
task :import_oes_data => [:environment] do
  file = "lib/data/2013-oe.data.0.Current"
  puts "Importing OE data"

  CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
    d = OccupationalStatistic.new
    series_id = row[0].gsub(' ', '')
    puts "importing series id: #{series_id} "
    d.original_series = series_id
    d.area = Area.find_by_code(series_id[4..10])
    d.industry = Industry.where(code: series_id[11..16].gsub("-", "0").to_i).first
    d.occupation = Occupation.find_by_code(series_id[17..22])
    d.data_type = DataType.where(code: series_id[-2..-1], data_category: 'OES').first
    d.year = row[1]
    d.period = row[2]
    d.value = row[3]
    d.save
  end
end