class Post < ApplicationRecord
  has_many :comments
  has_many :likes, as: :object
  belongs_to :user
end
