class CreateOccupationalStatistics < ActiveRecord::Migration
  def change
    create_table :occupational_statistics do |t|
      t.integer :seasonal_id
      t.integer :year
      t.string :period
      t.integer :value
      t.integer :area_id
      t.integer :industry_id
      t.integer :occupation_id
      t.integer :data_type_id

      t.timestamps
    end
  end
end
