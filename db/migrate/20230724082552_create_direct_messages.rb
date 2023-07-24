class CreateDirectMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :direct_messages do |t|

      t.integer :sender_user_id
      t.integer :receiver_user_id
      t.string :message
      t.timestamps
    end
  end
end
