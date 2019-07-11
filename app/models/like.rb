class Like < ApplicationRecord
  enum reaction_type: [ :like, :dislike, :laugh ]

  belongs_to :post, -> { where(object_class: 'Post') }, class_name: 'Post', foreign_key: :object_id
  belongs_to :comment, -> { where(object_class: 'Comment') }, class_name: 'Comment', foreign_key: :object_id
  belongs_to :user
end
