# == Schema Information
#
# Table name: report_criteria
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  report_id        :integer
#  criteriable_id   :integer
#  criteriable_type :string(255)
#

require 'spec_helper'

describe ReportCriterium do
  pending "add some examples to (or delete) #{__FILE__}"
end
