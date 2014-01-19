require 'csv'

desc "Import the known column mappings for the CES and OES imports"
task :import => [:environment] do
  file = "lib/data/bls_column_mappers.csv"
  puts "Importing BLS Column Data"
  CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
    BlsColumnMapper.first_or_create(
        web_column_name: row[1],
        application_object_attribute: row[2],
        application_object: row[3],
        data_type_id: row[6]
    )
  end

end
