# == Schema Information
#
# Table name: bls_column_mappers
#
#  id                           :integer          not null, primary key
#  web_column_name              :string(255)
#  application_object_attribute :string(255)
#  application_object           :string(255)
#  created_at                   :datetime
#  updated_at                   :datetime
#

class BlsColumnMapper < ActiveRecord::Base
end
