class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :object_id, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :reaction_type

      t.timestamps
    end

    add_index :likes, :object_id
  end
end
