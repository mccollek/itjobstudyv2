# == Schema Information
#
# Table name: seasonals
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Seasonal < ActiveRecord::Base
end
