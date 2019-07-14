class Friendship < ApplicationRecord
  enum status: [ :accepted, :rejected, :unfriended ]

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  def self.still_friends?(user,friend)
    where(user_id: user.id, friend_id: friend.id).last.accepted?
  end
end
