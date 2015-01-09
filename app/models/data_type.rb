# == Schema Information
#
# Table name: data_types
#
#  id            :integer          not null, primary key
#  code          :integer
#  name          :string(255)
#  footnote_code :integer
#  created_at    :datetime
#  updated_at    :datetime
#  data_category :string(255)
#

class DataType < ActiveRecord::Base
  has_many :occupational_statistics
  has_many :report_criteriums, as: :criteriable
  has_many :bls_column_mappers

  def typed_name
    "#{self.data_category}: #{self.name}"
  end
end
