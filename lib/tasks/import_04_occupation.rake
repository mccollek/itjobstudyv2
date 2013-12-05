require 'csv'

desc "Import occupations from txt file"
task :import => [:environment] do
  #unless Role.all.count > 0
  #  r = Role.create(name:'Admin')
  #  r.save
  #  r = Role.create(:name=>'User')
  #  r.save
  #end
  unless Occupation.all.count > 0
    file = "lib/data/oe.occupation"

    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      o = Occupation.new
      puts "Importing Occupation" + row[1]
      o.code = row[0]
      o.name = row[1]
      o.save
    end
  end
end