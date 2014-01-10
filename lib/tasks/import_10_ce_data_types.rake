require 'csv'

desc "Import data types from txt file"
task :import => [:environment] do
  file = "lib/data/ce.datatype"
  CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      dt = DataType.where(code: row[0], data_category: 'industry').first_or_initialize
      puts "Importing Data Type " + row[1]
      dt.code = row[0]
      dt.name = row[1]
      dt.data_category = 'CES'
      dt.save
    end
  end
