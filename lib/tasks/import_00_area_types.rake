require 'csv'

desc "Import Area Types from txt file"
task :import => [:environment] do
  #unless Role.all.count > 0
  #  r = Role.create(name:'Admin')
  #  r.save
  #  r = Role.create(:name=>'User')
  #  r.save
  #end
  unless AreaType.all.count > 0
    file = "lib/data/oe.areatype"

    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      at = AreaType.new
      puts "Importing Area Type " + row[1]
      at.code = row[0]
      at.name = row[1]
      at.save
    end
  end
end