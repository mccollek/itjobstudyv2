# == Schema Information
#
# Table name: occupation_groups
#
#  id         :integer          not null, primary key
#  code       :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class OccupationGroup < ActiveRecord::Base
end
