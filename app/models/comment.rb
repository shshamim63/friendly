class Comment < ApplicationRecord
  scope :commentindex, ->{ order("created_at DESC").last(2) }

  belongs_to :user
  belongs_to :post

  has_many :likes, as: :object, dependent: :destroy
  has_one_attached :image

  validates :content, presence: true
  validates :user_id, presence: true
  validate :image_type

  private

  def image_type
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png image/gif'))
        errors.add(:image, 'nedd to be a jpeg/png/gif')
      end
    end
  end
end
