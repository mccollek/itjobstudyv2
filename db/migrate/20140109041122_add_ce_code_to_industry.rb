class AddCeCodeToIndustry < ActiveRecord::Migration
  def change
    add_column :industries, :ce_code, :integer
  end
end
