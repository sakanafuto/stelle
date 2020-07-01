class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :prefecture
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user


  default_scope -> { order(created_at: :DESC) }

  validates :name, presence: true
  validates :caption, presence: true, length: { maximum: 300 }
  validates :image, presence: true
  validates :prefecture_id, presence: true

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def already_liked?(user)
    liked_users.include?(user)
  end
end
