class AddDataTypeIdToBlsColumnMapper < ActiveRecord::Migration
  def change
    add_column :bls_column_mappers, :data_type_id, :integer
  end
end
