require 'csv'

desc "Import IT-oLogy IT Communications"
task :import => [:environment] do
  file = 'lib/data/it_occupations.csv'
  unless Report.where(title: 'IT Jobs Criteria').first.nil?
    print 'creating report'
    itology_report = Report.new
    itology_report.title= 'IT Jobs Criteria'
    CSV.foreach(file, :headers => false, :col_sep => ";" ) do |row|
      print "importing row #{row[1]}"
      occupation_code = Occupation.convert_code(row[0])
      itology_report.occupations << Occupation.where(code: occupation_code)
    end
    itology_report.save!
  end
end