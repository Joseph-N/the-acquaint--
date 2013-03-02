class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :thread_id
      t.text :body

      t.timestamps
    end
    add_index :messages, [:sender_id, :receiver_id, :thread_id]
  end
end
