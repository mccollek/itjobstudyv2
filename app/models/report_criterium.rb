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

class ReportCriterium < ActiveRecord::Base
  belongs_to :reports
  belongs_to :criteriable, polymorphic: true
end
