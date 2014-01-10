require 'csv'

desc "Import data types from txt file"
task :import => [:environment] do
  #unless Role.all.count > 0
  #  r = Role.create(name:'Admin')
  #  r.save
  #  r = Role.create(:name=>'User')
  #  r.save
  #end
  unless DataType.all.count > 0
    file = "lib/data/oe.datatype"

    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      dt = DataType.new
      puts "Importing Data Type " + row[1]
      dt.code = row[0]
      dt.name = row[1]
      dt.data_category = 'OES'
      dt.save
    end
  end
end