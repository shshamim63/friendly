class User < ApplicationRecord
  enum gender: [ :male, :female, :other ]

  scope :all_except, ->(user) { where.not(id: user) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id


  validates :email, presence: true, length: { maximum: 255 }
  validates :first_name, :last_name, :username, :gender, :birthday,
    presence: true

  def friends
    friends_array = friendships.map do |friendship|
      friend = friendship.friend
      friend if Friendship.current_status?(self, friend)&.accepted?
    end
    inverse_friends_array = inverse_friendships.map do  |friendship|
      friend = friendship.user
      friend if Friendship.current_status?(friend, self)&.accepted?
    end
    (friends_array + inverse_friends_array).compact.uniq
  end

  def pending
    pending_array = friendships.map do  |friendship|
      friend = friendship.user
      friend if Friendship.current_status?(self, friend)&.pending?
    end
    pending_array.compact.uniq
  end

  def friend?(user)
    Friendship.current_status?(user, self)&.accepted?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
