class Post < ApplicationRecord
  scope :timeline, ->(users) { where(user_id: users).order(created_at: :desc) }

  has_many :comments, dependent: :destroy
  has_many :likes, as: :object, dependent: :destroy
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true

end
