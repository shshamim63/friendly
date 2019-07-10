class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies, class_name: 'Comment', foreign_key: :reply_id
  belongs_to :reply_from, optional: true, class_name: 'Comment', foreign_key: :reply_id
end
