# == Schema Information
#
# Table name: occupations
#
#  id            :integer          not null, primary key
#  code          :integer
#  name          :string(255)
#  display_level :integer
#  selectable    :boolean
#  sort_sequence :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Occupation < ActiveRecord::Base
  def self.convert_code(value)
    stringed_code = value.gsub("-","")
    stringed_code.to_i
  end
end
