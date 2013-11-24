# == Schema Information
#
# Table name: state_msas
#
#  id         :integer          not null, primary key
#  state_id   :integer
#  msa_code   :integer
#  msa_name   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe StateMsa do
  pending "add some examples to (or delete) #{__FILE__}"
end
