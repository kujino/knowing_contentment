class Post < ApplicationRecord
  belongs_to :user
  belongs_to :theme

  has_one_attached :image

  # ファイルの種類とサイズのバリデーション
  ACCEPTED_CONTENT_TYPES = %w[image/jpeg image/png image/webp].freeze
  validates :image, content_type: ACCEPTED_CONTENT_TYPES,
                    size: { less_than_or_equal_to: 5.megabytes }

  validates :content, presence: true
end
