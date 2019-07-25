class Friendship < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected, :unfriended ]

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  def self.still_friends?(user, friend)
    where(user_id: user.id, friend_id: friend.id).last&.accepted?
  end

  def self.current_status?(user, friend)
    where(user_id: user.id, friend_id: friend.id).last&
  end

end
