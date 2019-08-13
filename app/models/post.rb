class Post < ApplicationRecord
  scope :timeline, ->(users) { where(user_id: users).order(created_at: :desc) }

  has_many :comments, dependent: :destroy
  has_many :likes, as: :object, dependent: :destroy
  has_many_attached :images

  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true
  validate :image_type

  private
  def image_type
    if images.attached?
      images.each do |image|
        if !image.content_type.in?(%('image/jpeg image/png image/gif'))
          errors.add(:images, 'nedd to be a jpeg/png/gif')
        end
      end
    end
  end

end
