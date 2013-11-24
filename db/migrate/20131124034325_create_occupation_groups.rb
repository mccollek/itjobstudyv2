class CreateOccupationGroups < ActiveRecord::Migration
  def change
    create_table :occupation_groups do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
