class AddIdsToReportCriterium < ActiveRecord::Migration
  def change
    add_column :report_criteria, :report_id, :integer
    add_column :report_criteria, :criteriable_id, :integer
    add_column :report_criteria, :criteriable_type, :string
  end
end
