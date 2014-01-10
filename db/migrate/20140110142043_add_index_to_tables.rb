class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index(:data_types, :data_category)
    add_index(:data_types, :code)
    add_index(:occupational_statistics, :industry_id)
    add_index(:occupational_statistics, :occupation_id)
    add_index(:occupational_statistics, :data_type_id)
    add_index(:occupational_statistics, :area_id)
  end
end
