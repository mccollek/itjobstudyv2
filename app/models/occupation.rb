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
  has_many :occupational_statistics
  has_many :report_criteriums, as: :criteriable
  validates :name, presence: true
  validates :code, presence: true
  default_scope order('code ASC')
  def to_s
    self.name
  end

  def formatted_code
    stringed_code = self.code.to_s
    return "#{stringed_code[0..1]}-#{stringed_code[2,4]}"
  end

  def self.convert_code(value)
    stringed_code = value.gsub("-","")
    stringed_code.to_i
  end
end
