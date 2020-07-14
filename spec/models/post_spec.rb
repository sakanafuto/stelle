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
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  
  it "ファクトリが有効である" do
    expect(post).to be_valid
  end

  it "ユーザー、名前、キャプション、画像、都道府県がある場合、有効" do
    user = create(:user)
    prefecture = create(:prefecture)
    post = Post.new(
      user: user,
      name: '名古屋城',
      caption: 'よき',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.jpg')),
      prefecture: prefecture
    )
    expect(post).to be_valid
  end

  describe "存在性の検証" do

    it "名前がない場合、無効" do
      post.name = nil
      post.valid?
      expect(post).to_not be_valid
    end
  
    it "キャプションがない場合、無効" do
      post.caption = nil
      post.valid?
      expect(post).to_not be_valid
    end
  
    it "画像がない場合、無効" do
      post.image = nil
      post.valid?
      expect(post).to_not be_valid
    end

    it "都道府県がない場合、無効" do
      post.prefecture_id = nil
      post.valid?
      expect(post).to_not be_valid
    end
  end
    
end
