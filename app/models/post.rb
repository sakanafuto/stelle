class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :prefecture

  default_scope -> { order(created_at: :DESC) }

  validates :name, presence: true
  validates :caption, presence: true, length: { maximum: 300 }
  validates :image, presence: true
  validates :prefecture_id, presence: true
end
