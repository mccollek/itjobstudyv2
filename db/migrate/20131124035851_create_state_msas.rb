class CreateStateMsas < ActiveRecord::Migration
  def change
    create_table :state_msas do |t|
      t.integer :state_id
      t.integer :msa_code
      t.string :msa_name

      t.timestamps
    end
  end
end
