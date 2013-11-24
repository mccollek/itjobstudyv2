class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.integer :code
      t.string :name
      t.integer :display_level
      t.boolean :selectable
      t.integer :sort_sequence

      t.timestamps
    end
  end
end
