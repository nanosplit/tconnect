class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.text :media_url
      
      t.bigint :classroom_id
      t.bigint :message_sendable_id
      t.string :message_sendable_type

      t.timestamps
    end
  end
end
