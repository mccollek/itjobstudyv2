# == Schema Information
#
# Table name: areas
#
#  id           :integer          not null, primary key
#  code         :integer
#  area_type_id :integer
#  name         :string(255)
#  state        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Area < ActiveRecord::Base
  belongs_to :area_type
  has_many :report_criteriums, as: :criteriable

  def self.parse_area(attribute)
    if attribute =~ /^[a-zA-Z]*/
      found_area = self.where(state: attribute).take!
      found_area ||= self.where(name: attribute).take!
    else
      found_area = self.where(code: attribute).take!
    end
    if found_area.present?
      return found_area
    else
      raise('no area found')
    end
  end
end
