class Like < ApplicationRecord
  enum reaction_type: [ :like, :dislike, :laugh ]

  scope :liking, -> { where(reaction_type: 'like') }
  scope :disliking, -> { where(reaction_type: 'dislike') }
  scope :laughing, -> { where(reaction_type: 'laugh') }

  belongs_to :object, polymorphic: true
  belongs_to :user
end
