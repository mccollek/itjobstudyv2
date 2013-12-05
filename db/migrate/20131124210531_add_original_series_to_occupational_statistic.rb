class AddOriginalSeriesToOccupationalStatistic < ActiveRecord::Migration
  def change
    add_column :occupational_statistics, :original_series, :string
  end
end
