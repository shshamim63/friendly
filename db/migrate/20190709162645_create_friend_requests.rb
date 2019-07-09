class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :accepted

      t.timestamps
    end

    add_index :friend_requests, :sender_id
    add_index :friend_requests, :receiver_id
    add_index :friend_requests, :accepted
    add_index :friend_requests, [:sender_id, :receiver_id] , unique: true
    add_foreign_key :friend_requests, :users, column: :sender_id
    add_foreign_key :friend_requests, :users, column: :receiver_id
  end
end
