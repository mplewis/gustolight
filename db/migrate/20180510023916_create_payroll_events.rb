class CreatePayrollEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :payroll_events do |t|
      t.string :company_id_hash
      t.datetime :processing_timestamp
      t.timestamps
    end
    add_index :payroll_events, :processing_timestamp
    add_index :payroll_events, [:company_id_hash, :processing_timestamp], name: :index_payroll_events_on_company_and_timestamp
  end
end
