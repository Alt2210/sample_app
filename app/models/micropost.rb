class Micropost < ApplicationRecord
  belongs_to :user
  scope :newest, ->{order(created_at: :desc)}
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: Settings.image.resize_limit
  end

  validates :content, presence: true,
                      length: {maximum: Settings.limit.digit_140}
  validates :image,
            content_type: {
              in: Settings.image.accept_formats,
              message: :invalid_image_format
            },
            size: {
              less_than: Settings.image.size_limit_5.megabytes,
              message: :image_too_large
            }
end
