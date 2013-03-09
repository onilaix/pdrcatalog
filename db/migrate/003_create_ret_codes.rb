class CreateRetCodes < ActiveRecord::Migration
  def change
    create_table :ret_codes do |t|
      t.string :code
      t.string :description
      t.string :cm_description
      t.string :crm_fields
      t.string :comment
      t.references :pdr
      t.timestamps

    end
    add_index :ret_codes, :pdr_id
  end
end
