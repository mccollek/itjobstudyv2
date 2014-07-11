require 'csv'

desc "Import Area from txt file"
task :import_area => [:environment] do
  fileset = ["lib/data/oe.area","lib/data/sm.area"]
  fileset.each  do |file|
    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      case file
        when "lib/data/oe.area"
          name = row[2]
          area_type = row[1]
        else
          name = row[1]
          area_type = nil
      end
      Area.where(code: row[0]).first_or_create do |a|
        puts "Importing Area " + name
        a.code = row[0]
        a.area_type = AreaType.find_by code: area_type
        a.name = name
      end
    end
  end
end