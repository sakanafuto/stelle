# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  caption       :text(65535)
#  image         :string(255)
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :bigint           not null
#  user_id       :bigint
#
# Indexes
#
#  index_posts_on_prefecture_id  (prefecture_id)
#  index_posts_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (prefecture_id => prefectures.id)
#  fk_rails_...  (user_id => users.id)
#
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
