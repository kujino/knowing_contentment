class Post < ApplicationRecord
  belongs_to :user
  belongs_to :theme
  has_many :reactions, dependent: :destroy

  has_one_attached :image

  # ファイルの種類とサイズのバリデーション
  ACCEPTED_CONTENT_TYPES = %w[image/jpeg image/png image/webp].freeze
  validates :image, content_type: ACCEPTED_CONTENT_TYPES,
                    size: { less_than_or_equal_to: 5.megabytes }

  validates :content, presence: true, length: { maximum: 300 }

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "is_anonymous", "theme_id", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "reactions", "theme", "user"]
  end

end
