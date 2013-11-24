# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  code       :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class State < ActiveRecord::Base
end
