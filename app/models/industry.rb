# == Schema Information
#
# Table name: industries
#
#  id            :integer          not null, primary key
#  code          :integer
#  name          :string(255)
#  display_level :integer
#  selectable    :boolean
#  sort_sequence :integer
#  created_at    :datetime
#  updated_at    :datetime
#  ce_code       :integer
#

class Industry < ActiveRecord::Base
  has_many :occupational_statistics
  has_many :report_criteriums, as: :criteriable
  default_scope order('code ASC')

  def formatted_code
    stringed_code = self.code.to_s
    return "#{stringed_code[0..1]}-#{stringed_code[2,4]}"
  end
end
