require 'csv'

desc "Import National Current Employment Statistics from txt file"
task :import_ces_national => [:environment] do
    file = "lib/data/ce.data.0.AllCESSeries"
    #file = "lib/data/ce_national_test" # test file
    p "Importing CES National data"
    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      series_id = row[0].gsub(' ', '')
      d = OccupationalStatistic.new
      p "importing series id: #{series_id} "
      d.original_series = series_id
      d.area_id = 1
      d.industry = Industry.where(code: series_id[3..10].to_i).first
      d.data_type = DataType.where(code: series_id[11..12], data_category: 'CES').first
      d.year = row[1]
      d.period = row[2]
      d.value = row[3]
      d.save
    end
end