class ChangeOccupationalStatistic < ActiveRecord::Migration
  def change
    remove_column :occupational_statistics, :value, :integer
    add_column :occupational_statistics, :value, :decimal
  end
end
