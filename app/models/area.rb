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
end
