require 'csv'

desc "Import industries from txt file. Since CE has summary occupations that overlap OE, " + \
      "check for the summaries and code them with the CE custom code"
task :import => [:environment] do
  file = "lib/data/ce.industry"
  CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
      naics_code = row[1]
      if naics_code == '-'  #summary codes
        naics = row[0].to_i
        p "summary code "
      else                  #everything else
        naics = row[0][2..7].to_i
        p "real "
      end
      print "naics is #{naics} \n"
      industry = Industry.where(code: naics).first_or_initialize
      industry.code ||= naics
      industry.ce_code = row[0]
      industry.name ||= row[3]
      industry.display_level ||= row[4]
      industry.selectable ||= (row[5] == 'T')
      industry.sort_sequence ||= row[6]
      if industry.created_at == nil
        p "adding "
      else
        p "updating "
      end
      p "industry #{industry.name} with code #{industry.code} \n"
      industry.save
    end
end
