require 'csv'

desc "Import the state abbreviations into th areas"
task :import_states => [:environment] do
  file = "lib/data/states.csv"
  puts "Importing Sates"
  CSV.foreach(file, :headers => true, :col_sep => "," ) do |row|
    a = Area.where(name: row[0]).first
    a.state = row[2]
    a.save
  end
end
