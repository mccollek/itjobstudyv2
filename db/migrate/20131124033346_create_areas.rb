class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :code
      t.integer :area_type_id
      t.string :name
      t.string :state

      t.timestamps
    end
  end
end
