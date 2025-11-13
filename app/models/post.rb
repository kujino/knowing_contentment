class Post < ApplicationRecord
  belongs_to :user
  belongs_to :theme

  validates :content, presence: true
end
