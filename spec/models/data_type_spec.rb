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

require 'spec_helper'

describe DataType do
  pending "add some examples to (or delete) #{__FILE__}"
end
