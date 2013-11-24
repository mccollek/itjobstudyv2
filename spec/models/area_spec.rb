# == Schema Information
#
# Table name: areas
#
#  id           :integer          not null, primary key
#  code         :integer
#  area_type_id :integer
#  name         :string(255)
#  state        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Area do
  pending "add some examples to (or delete) #{__FILE__}"
end
