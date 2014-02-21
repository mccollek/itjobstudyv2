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
#  data_type_id                 :integer
#

require 'spec_helper'

describe BlsColumnMapper do
  pending "add some examples to (or delete) #{__FILE__}"
end
