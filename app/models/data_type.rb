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
#

class DataType < ActiveRecord::Base
end
