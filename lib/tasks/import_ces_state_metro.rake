require 'csv'

desc "Import State and Metro Current Employment Statistics from txt file"
task :import_ces_state_metro => [:environment] do
    file = "lib/data/sm.data.0.Current"
    #file = "lib/data/sm_test" # test file
    p "Importing CES state & Metro data"
    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      series_id = row[0].gsub(' ', '')
      d = OccupationalStatistic.new
      p "importing series id: #{series_id}"
      d.original_series = series_id
      tmp_state_area = row[0][3..9].to_i
      tmp_area = row[0][5..9].to_i
      if tmp_area < 100  #regions and states are inclusive of the state code, metro areas are not
        d.area =Area.where(code: tmp_state_area).first
      else
        d.area =Area.where(code: tmp_area).first
      end
      naics_code = series_id[12..17].to_i
      if naics_code == 0  #summary codes
        naics = series_id[10..17].to_i
        p "summary code "
      else                  #everything else
        naics = naics_code
        p "real "
      end
      d.industry = Industry.where(code: naics).first
      d.data_type = DataType.where(code: d.original_series[-2..-1].to_i, data_category: 'ces')
      d.year = row[1]
      d.period = row[2]
      d.value = row[3]
      d.save
    end
end