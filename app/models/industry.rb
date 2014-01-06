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
#

class Industry < ActiveRecord::Base
  has_many :report_criteriums, as: :criteriable
end
