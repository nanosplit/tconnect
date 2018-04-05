class CreateMessageInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :message_invoices do |t|
      t.references :message, foreign_key: true
      
      t.integer :amount
      t.bigint :message_invoiceable_id
      t.string :message_invoiceable_type
      t.bigint :payer_id
      t.string :payer_type

      t.timestamps
    end
  end
end
