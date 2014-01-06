class Report < ActiveRecord::Base
  has_many :report_criteriums
  has_many :occupations, through: :report_criteriums, source: :criteriable, source_type: 'Occupation'
  has_many :industries, through: :report_criteriums, source: :criteriable, source_type: 'Industry'
end
