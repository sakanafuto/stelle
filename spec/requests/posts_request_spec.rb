require 'rails_helper'

RSpec.describe "Posts", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/posts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/posts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/posts/new"
      expect(response).to have_http_status(:success)
    end
  end


  context '都道府県で検索できているか' do
    # postの作成
    before do
      user = create(:user)
      prefecture = create(:prefecture, name: "愛知県")
      @post = create(
        :post,
        user: user,
        prefecture: prefecture
      )

      other_prefecture = create(:prefecture, name: "福井県")
      @other_post = create(
        :post,
        user: user,
        prefecture: other_prefecture
      )
    end

    it '@postを返すこと' do
      expect(Post.ransack(prefecture_id: @post.prefecture.id)).to be_empty
    end

    it '@other_postを返さないこと' do
      expect(Post.ransack(prefecture_id: @other_post.prefecture.id)).to_not be_empty
    end
  end
end
