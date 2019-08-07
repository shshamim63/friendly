require 'open-uri'

class User < ApplicationRecord
  enum gender: [ :male, :female, :other ]

  scope :all_except, ->(user) { where.not(id: user) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :email, presence: true, length: { maximum: 255 }
  validates :first_name, :last_name, :username, presence: true
  validates :gender, presence: true, unless: -> { created_with_facebook? }

  validate :avatar_type

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_one_attached :avatar

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

  def pending(logged_in_user)
    pending_array = inverse_friendships.map do  |friendship|
      friend = friendship.user
      friendship = Friendship.current_status?(friend, self)
      friend if friendship&.pending? && friendship.user != logged_in_user
    end
    pending_array.compact.uniq
  end

  def friend?(user)
    Friendship.current_status?(user, self)&.accepted?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def created_with_facebook?
    provider == 'facebook'
  end

  def self.from_omniauth(auth)
    find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.username =  "#{auth.info.first_name}" + ' ' + "#{auth.info.last_name}"
      user.birthday = auth.extra.raw_info.birthday
      user.gender = auth.extra.raw_info.gender
      # downloaded_image = open(auth.info.image)
      # byebug
      # user.avatar.attach(io: downloaded_image  , filename: "foo.jpeg")

      user.save
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.first_name = data['first_name']
        user.last_name = data['last_name']
        user.password = Devise.friendly_token[0, 20]
        user.email = data["email"] if user.email.blank?
        user.username =  data['first_name'] + ' ' + data['last_name']
        user.birthday = data['birthday']
        user.gender = data['gender']

        user.save
      end
    end
  end

  private

  def avatar_type
    if avatar.attached?
      if !avatar.content_type.in?(%('image/jpeg image/png'))
        errors.add(:avatar, 'nedd to be a jpeg/png')
      end
    end
  end
end
