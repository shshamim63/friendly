class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.integer :reply_id

      t.timestamps
    end

    add_index :comments, :reply_id
    add_foreign_key :comments, :comments, column: :reply_id
  end
end
