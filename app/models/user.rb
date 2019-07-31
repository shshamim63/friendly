class User < ApplicationRecord
  enum gender: [ :male, :female, :other ]

  scope :all_except, ->(user) { where.not(id: user) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_one_attached :avatar


  validates :email, presence: true, length: { maximum: 255 }
  validates :first_name, :last_name, :gender, :birthday,
    presence: true
  validate :avatar_type

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name   # assuming the user model has a name
      user.last_name = auth.info.name
      user.username = auth.info.name
      user.birthday = auth.info.birthday
      user.gender = auth.info.gender # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
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
