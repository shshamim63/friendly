class Like < ApplicationRecord
  enum reaction_type: [ :like, :dislike, :laugh ]

  scope :like, -> { where(reaction_type: 'like') }
  scope :dislike, -> { where(reaction_type: 'dislike') }
  scope :laugh, -> { where(reaction_type: 'laugh') }

  belongs_to :object, polymorphic: true
  belongs_to :user
end
