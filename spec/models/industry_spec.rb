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
#  ce_code       :integer
#

require 'spec_helper'

describe Industry do
  pending "add some examples to (or delete) #{__FILE__}"
end
