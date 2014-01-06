class CreateReportCriteria < ActiveRecord::Migration
  def change
    create_table :report_criteria do |t|
      t.string :title
      t.timestamps
    end
  end
end
