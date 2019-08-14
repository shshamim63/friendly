class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :reply_from,
   optional: true,
   class_name: 'Comment',
   foreign_key: :reply_id

  has_many :replies, class_name: 'Comment', foreign_key: :reply_id
  has_many :likes, as: :object

  validates :content, presence: true
  validates :user_id, presence: true
end
