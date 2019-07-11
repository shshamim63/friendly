class User < ApplicationRecord
  enum gender: [ :male, :female, :other ]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  # validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true , length: { maximum: 255 }

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.accepted? }
    friends_array + inverse_friendships.map { |friendship| friendship.user if friendship.accepted? }
    friends_array.compact
  end
end
