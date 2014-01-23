require 'csv'

desc "Import IT-oLogy IT Communications"
task :import_it_ology => [:environment] do
  file = 'lib/data/it_occupations.csv'
  file2 = 'lib/data/it_industries.csv'
  if Report.where(title: 'IT Jobs Criteria').first.nil?
    p 'creating report'
    itology_report = Report.new
    itology_report.title= 'IT Jobs Criteria'
    CSV.foreach(file, :headers => false, :col_sep => ";" ) do |row|
      p "importing occ row #{row[1]}"
      occupation_code = Occupation.convert_code(row[0])
      itology_report.occupations << Occupation.where(code: occupation_code)
    end
    CSV.foreach(file2, :headers => false, :col_sep => ";" ) do |row|
      p "importing ind row #{row[0]}"
      itology_report.industries << Industry.where(code: row[0])
    end
    itology_report.save!
  end
end