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

class StateMsa < ActiveRecord::Base
  belongs_to :state
end
