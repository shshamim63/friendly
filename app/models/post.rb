class Post < ApplicationRecord
  has_many :comments
  has_many :likes, class_name: 'Like', foreign_key: :object_id 
  belongs_to :user
end
