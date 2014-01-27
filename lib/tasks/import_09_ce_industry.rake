require 'csv'

desc "Import industries from txt file. Since CE has summary occupations that overlap OE, " + \
      "check for the summaries and code them with the CE custom code"
task :import => [:environment] do
  fileset = ["lib/data/ce.industry","lib/data/sm.industry"]
  fileset.each do |file|
    CSV.foreach(file, :headers => true, :col_sep => "\t" ) do |row|
        naics_code = row[0][2..7].to_i
        if naics_code == 0  #summary codes
          naics = row[0].to_i
          p "summary code "
        else                  #everything else
          naics = row[0][2..7].to_i
          p "real "
        end
        file == "lib/data/ce.industry" ? industry_name = row[3] : industry_name = row[1]
        print "naics is #{naics} \n"
        industry = Industry.where(code: naics).first_or_initialize
        industry.code ||= naics
        industry.ce_code = row[0]
        industry.name ||= industry_name
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
end
