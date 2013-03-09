class CreateMvnoProcs < ActiveRecord::Migration
  def change
    create_table :mvno_procs do |t|
      t.integer :pdrtype
      t.string :name

      t.timestamps
    end
  end
end
