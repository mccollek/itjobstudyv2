require 'csv'

desc "Import National Current Employment Statistics from txt file"
task :import_ces_national_2013 => [:environment] do
    file = "lib/data/2013-ce.data.0.AllCESSeries"
    #file = "lib/data/ce_national_test" # test file
    p "Importing CES National data"
    start = false
    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      series_id = row[0].gsub(' ', '')
      # if series_id == 'CEU6056133034' then start=true end
      start=true
      if start
        # d = OccupationalStatistic.new
        year = row[1]
        if year=='2013' || year=='2014'
          p "importing series id: #{series_id} "
          original_series = series_id
          area_id = 1
          industry = Industry.where(code: series_id[5..10].to_i).first
          if industry.nil?
            pp "can't find id for row: #{row}"
            break
          end
          data_type = DataType.where(code: series_id[11..12], data_category: 'CES').first

          period = row[2]
          value_final = row[3]

          os = OccupationalStatistic.new(data_type: data_type,
                                                           value: value_final,
                                                           year: year,
                                                           area_id: area_id,
                                                           industry: industry,
                                                           original_series: original_series,
                                                           period: period)
            p "about to save the following stat: \n"
            pp os
            os.save!
        end
        # d.save
      end
    end
end