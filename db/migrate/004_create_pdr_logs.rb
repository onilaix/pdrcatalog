class CreatePdrLogs < ActiveRecord::Migration
  def change
    create_table :pdr_logs do |t|
      t.integer :pdrtype
      t.string :name
      t.string :action
      t.string :username
      t.string :pdrstring1
      t.string :pdrstring2
      t.string :pdrstring3
      t.string :pdrstring4
      t.string :pdrstring5
      t.string :pdrstring6
      t.string :pdrstring7
      t.string :pdrstring8
      t.string :pdrstring9
      t.string :pdrstring10
      t.string :pdrstring11
      t.string :pdrstring12
      t.string :pdrstring13
      t.string :pdrstring14
      t.string :pdrstring15
      t.string :pdrstring16
      t.string :pdrstring17
      t.string :pdrstring18
      t.string :pdrstring19
      t.string :pdrstring20
      t.string :pdrstring21
      t.string :pdrstring22
      t.string :pdrstring23
      t.string :pdrstring24
      t.string :pdrstring25
      t.string :pdrstring26
      t.string :pdrstring27
      t.string :pdrstring28
      t.string :pdrstring29
      t.string :pdrstring30
      t.string :pdrstring31
      t.string :pdrstring32
      t.string :pdrstring33
      t.string :pdrstring34
      t.string :pdrstring35
      t.string :pdrstring36
      t.string :pdrstring37
      t.string :pdrstring38
      t.string :pdrstring39
      t.string :pdrstring40
      t.string :crm_flag
      t.string :dwh_flag
      t.string :description
      t.string :from_system
      t.string :to_system
      t.text   :notes

      t.timestamps
    end
  end
end
