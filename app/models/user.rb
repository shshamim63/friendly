class User < ApplicationRecord
  enum gender: [ :male, :female, :other ]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, -> { where status: 'accepted' }
  has_many :inverse_friendships, -> { where status: 'accepted' }, class_name: 'Friendship', foreign_key: :friend_id

  # validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true , length: { maximum: 255 }

  def friends
    friends_array = friendships.map do |friendship|
      friend = friendship.friend
      friend if Friendship.still_friends?(self, friend)
    end
    inverse_friends_array = inverse_friendships.map do  |friendship|
      friend = friendship.user
      friend if Friendship.still_friends?(friend, self)
    end
    (friends_array + inverse_friends_array).compact
  end
end
