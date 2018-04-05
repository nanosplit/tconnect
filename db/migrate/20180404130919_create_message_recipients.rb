class CreateMessageRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :message_recipients do |t|
      t.references :message, foreign_key: true
      t.bigint :message_receivable_id
      t.bigint :message_receivable_type
      

      t.timestamps
    end
  end
end
