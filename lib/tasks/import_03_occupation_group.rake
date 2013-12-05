require 'csv'

desc "Import occupation groups from txt file"
task :import => [:environment] do
  #unless Role.all.count > 0
  #  r = Role.create(name:'Admin')
  #  r.save
  #  r = Role.create(:name=>'User')
  #  r.save
  #end
  unless OccupationGroup.all.count > 0
    file = "lib/data/oe.occugroup"

    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      og = OccupationGroup.new
      puts "Importing Data Type " + row[1]
      og.code = row[0]
      og.name = row[1]
      og.save
    end
  end
end