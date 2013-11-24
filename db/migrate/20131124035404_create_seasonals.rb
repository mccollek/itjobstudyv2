class CreateSeasonals < ActiveRecord::Migration
  def change
    create_table :seasonals do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
