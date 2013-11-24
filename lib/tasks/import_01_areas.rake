require 'csv'

desc "Import Area from txt file"
task :import => [:environment] do
  #unless Role.all.count > 0
  #  r = Role.create(name:'Admin')
  #  r.save
  #  r = Role.create(:name=>'User')
  #  r.save
  #end
  unless Area.all.count > 0
    file = "lib/data/oe.area"

    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      a = Area.new
      puts "Importing Area " + row[2]
      a.code = row[0]
      a.area_type = AreaType.find_by code: row[1]
      a.name = row[2]
      a.save
    end
  end
end