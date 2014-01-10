class AddDataCategoryToDataType < ActiveRecord::Migration
  def change
    add_column :data_types, :data_category, :string
  end
end
