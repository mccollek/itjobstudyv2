# == Schema Information
#
# Table name: occupational_statistics
#
#  id              :integer          not null, primary key
#  seasonal_id     :integer
#  year            :integer
#  period          :string(255)
#  area_id         :integer
#  industry_id     :integer
#  occupation_id   :integer
#  data_type_id    :integer
#  created_at      :datetime
#  updated_at      :datetime
#  value           :decimal(, )
#  original_series :string(255)
#

class OccupationalStatistic < ActiveRecord::Base
  belongs_to :seasonal
  belongs_to :occupation
  belongs_to :area
  belongs_to :industry
  belongs_to :data_type
end
