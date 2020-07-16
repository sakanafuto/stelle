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
    
  describe "文字数の検証" do
    
    it "300文字以内キャプションの場合、有効" do
      post.caption = "a" * 300
      expect(post).to be_valid
    end

    it "301文字を超えるキャプションの場合、無効" do
      post.caption =  "a" * 301
      post.valid?
      expect(post.errors).to be_added(:caption, :too_long, count: 300)
    end
  end

  describe "その他機能" do

    it '投稿をいいね/いいね解除できること' do
      Taro = create(:user)
      Jiro = create(:user, :with_posts, posts_count: 1)
      expect(Jiro.posts.first.already_liked?(Taro)).to eq false
      Jiro.posts.first.like(Taro)
      expect(Jiro.posts.first.already_liked?(Taro)).to eq true
      Jiro.posts.first.unlike(Taro)
      expect(Jiro.posts.first.already_liked?(Taro)).to eq false
    end
  end
end
