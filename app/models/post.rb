class Post < ApplicationRecord
  has_many :comments
  has_many :likes, as: :object
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true

  scope :desc,-> {order("posts.created_at DESC")}
end
