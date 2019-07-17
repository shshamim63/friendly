class Like < ApplicationRecord
  enum reaction_type: [ :like, :dislike, :laugh ]

  belongs_to :object, polymorphic: true
  belongs_to :user
end
