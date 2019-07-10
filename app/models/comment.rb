class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :replies, class_name: "comment",
                            foreign_key: "reply_id"
  belongs_to :, class_name: "comment"
end
