class CreateDataTypes < ActiveRecord::Migration
  def change
    create_table :data_types do |t|
      t.integer :code
      t.string :name
      t.integer :footnote_code

      t.timestamps
    end
  end
end
