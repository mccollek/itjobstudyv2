require 'csv'

desc "Import National Current Employment Statistics from txt file"
task :import_ces_national => [:environment] do
    file = "lib/data/ce.data.0.AllCESSeries"
    #file = "lib/data/ce_national_test" # test file
    p "Importing CES National data"
    start = false
    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      series_id = row[0].gsub(' ', '')
      if series_id == 'CEU6056133034' then start=true end
      if start
        # d = OccupationalStatistic.new
        p "importing series id: #{series_id} "
        original_series = series_id
        area_id = 1
        industry = Industry.where(code: series_id[3..10].to_i).first
        data_type = DataType.where(code: series_id[11..12], data_category: 'CES').first
        year = row[1]
        period = row[2]
        value_final = row[3]
        os = OccupationalStatistic.find_or_initialize_by(data_type: data_type,
                                                         value: value_final,
                                                         year: year,
                                                         area: area_id,
                                                         industry: industry,
                                                         original_series: original_series,
                                                         period: period)
        if os.new_record?
          statistic_attributes.each do |statistic_attribute_set|
            os.send("#{statistic_attribute_set[:stat_object].downcase}=",
                    statistic_attribute_set[:stat_object].constantize.where(statistic_attribute_set[:stat_attribute].to_sym => statistic_attribute_set[:stat_value]).first)
          end
          p "about to save the following stat: \n"
          pp os
          #debugger
          os.save!
        else
          p "record of type #{data_type.name} with value #{value_final}  already exists \n"
        end
        # d.save
      end
    end
end