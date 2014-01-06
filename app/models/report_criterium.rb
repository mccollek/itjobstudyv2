class ReportCriterium < ActiveRecord::Base
  belongs_to :reports
  belongs_to :criteriable, polymorphic: true
end
