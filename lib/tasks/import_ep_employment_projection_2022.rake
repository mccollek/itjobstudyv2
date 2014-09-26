require 'csv'

desc "Import Employment Projection Data from csv file"
task :import_ep_data => [:environment] do
  file = "lib/data/2022EmploymentProjections.csv"
  puts "Importing EP data"

  CSV.foreach(file, :headers => true, :col_sep => "," ) do |row|
    soc_code = row[1]
    @occupation = Occupation.find_by(code:Occupation.convert_code(soc_code))
    @area = Area.find_by(name: 'National')
    @year = 2022
    @data_set = [
        'Employment'=> row[3],
        'Project Net Job Growth'=> row[4],
        'Projected % Increase'=> row[5],
        'Projected Job openings due to growth and replacement needs' => row[6]
    ]
    @education_code = row[9]
    @work_experience_code = row[11]
    @training_code = row[13]
    #TODO: Import education, work experience, and training options into system as new classes (and add as new rake task)
    #TODO: add above dataTypes to database (and add to import_02_data_types rake task)
    #TODO: loop through above data set to add stats to system
    #TODO: add education, work experience, and training to the occupation
    @data_type = DataType.find_by(name: 'Projected Jobs')
    unless OccupationalStatistic.where().present?
      puts "importing projection for soc id: #{soc_code} "
      puts 'importing projected jobs'
      OccupationalStatistic.find_or_create_by(occupation: @occupation, area: @area, year: @year, data_type: @data_type, value: row[3])
      occupation = Occupation.find_by(code: Occupation.convert_code(soc_code))

      d.area = Area.find_by(code: series_id[4..10])
      d.industry = Industry.where(code: series_id[11..16].gsub("-", "0").to_i).first
      d.occupation = Occupation.find_by_code(Occupation.convert_code(soc_code))
      d.data_type = DataType.where(code: series_id[-2..-1], data_category: 'EP').first
      d.year = row[1]
      d.period = row[2]
      d.value = row[3]
      d.save
    end

  end
end