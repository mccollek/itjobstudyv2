require 'csv'

desc "Import occupations from txt file. replaces dashes in industry code with zeroes"
task :import => [:environment] do
  #unless Role.all.count > 0
  #  r = Role.create(name:'Admin')
  #  r.save
  #  r = Role.create(:name=>'User')
  #  r.save
  #end
  unless Industry.all.count > 0
    file = "lib/data/oe.industry"

    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      i = Industry.new
      puts "Importing Industry" + row[1]
      i.code = row[0].gsub("-", "0").to_i
      i.name = row[1]
      i.display_level = row[2]
      i.selectable = (row[3] == 'T')
      i.sort_sequence = row[4]
      i.save
    end
  end
end