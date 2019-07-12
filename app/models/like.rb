class Like < ApplicationRecord
  enum reaction_type: [ :like, :dislike, :laugh ]

  belongs_to :post, class_name: 'Post', foreign_key: :object_id
  belongs_to :comment, class_name: 'Comment', foreign_key: :object_id
  belongs_to :user
end
