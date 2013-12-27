class CreateBlsColumnMappers < ActiveRecord::Migration
  def change
    create_table :bls_column_mappers do |t|
      t.string :web_column_name
      t.string :application_object_attribute
      t.string :application_object
      t.timestamps
    end
  end
end
