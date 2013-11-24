class CreateAreaTypes < ActiveRecord::Migration
  def change
    create_table :area_types do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
