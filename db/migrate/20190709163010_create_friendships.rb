class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end

    add_index :friendships, :sender_id
    add_index :friendships, :receiver_id
    add_foreign_key :friendships, :users, column: :sender_id
    add_foreign_key :friendships, :users, column: :receiver_id
  end
end
