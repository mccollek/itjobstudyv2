# == Schema Information
#
# Table name: area_types
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class AreaType < ActiveRecord::Base
  has_many :areas
end
