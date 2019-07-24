class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :likes, as: :object, dependent: :destroy

  validates :content, presence: true
  validates :user_id, presence: true
end
