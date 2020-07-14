# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  avatar                 :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  guest                  :boolean          default(FALSE)
#  name                   :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  it "ファクトリが有効である" do
    expect(build(:user)).to be_valid
  end

  it "名前、メール、パスワードがある場合、有効" do
    user = User.new(
      name: 'TestUser',
      email: 'test@sample.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  describe "存在性の検証" do

    it "名前がない場合、無効" do
      @user.name = nil
      @user.valid?
      expect(@user).to_not be_valid
    end
  
    it "メールアドレスがない場合、無効" do
      @user.email = nil
      @user.valid?
      expect(@user).to_not be_valid
    end
  
    it "パスワードがない場合、無効" do
      @user.password = nil
      @user.valid?
      expect(@user).to_not be_valid
    end
  end

  describe "文字数の検証" do
    
    it "20文字以内名前の場合、有効" do
      @user.name = "a" * 20
      expect(@user).to be_valid
    end

    it "20文字を超える名前の場合、無効" do
      @user.name =  "a" * 21
      @user.valid?
      expect(@user.errors).to be_added(:name, :too_long, count: 20)
    end
    
    it "255文字以内のメールアドレスの場合、有効" do
      @user.email = "a" * 243 + '@example.com'
      expect(@user).to be_valid
    end
    
    it "255文字を超えるメールアドレスの場合、無効" do
      @user.email = "a" * 244 + '@example.com'
      @user.valid?
      expect(@user.errors).to be_added(:email, :too_long, count: 255)
    end
    
    it "6文字以上のパスワードの場合、有効" do
      @user.password = "a" * 6
      expect(@user).to be_valid
    end
    
    it "6文字未満のパスワードの場合、無効" do
      @user.password = "a" * 5
      @user.valid?
      expect(@user.errors).to be_added(:password, :too_short, count: 6)
    end
  end
    
  describe "一意性の検証" do
    
    it "重複したメールアドレスの場合、無効" do
      user1 = FactoryBot.create(:user, email: "test@sample.com")
      user2 = FactoryBot.build(:user, email: "test@sample.com")
      user2.valid?
      expect(user2).to_not be_valid
    end
    
    it "メールアドレスは大小文字を区別せず扱う" do
      user1 = FactoryBot.create(:user, email: "test@sample.com")
      user2 = FactoryBot.build(:user, email: "TEST@SamplE.cOm")
      user2.valid?
      expect(user2).to_not be_valid
    end
  end

  describe "フォーマットの検証" do
    it "正常なフォーマットのメールアドレスの場合、有効" do
      email = %w[sample@example.com sample@sample.sample S.A.M@P.L.E]
      email.each do |valid_email|
        @user.email = valid_email
        expect(@user).to be_valid
      end
    end

    it "正常でないフォーマットのメールアドレスの場合、無効" do
      email = %w[sample@example,com sample_sample.sample S.A.M@P.L.E.]
      email.each do |invalid_email|
        @user.email = invalid_email
        @user.valid?
        expect(@user).to_not be_valid
      end
    end

    it "パスワードが暗号化されていない場合、無効" do
      user = create(:user)
      expect(user.encrypted_password).to_not eq 'password'
    end
  end

  describe "その他機能" do

    it 'ユーザーをフォロー/フォロー解除できること' do
      Taro = create(:user)
      Jiro = create(:user)
      expect(Taro.following?(Jiro)).to eq false
      Taro.follow(Jiro)
      expect(Taro.following?(Jiro)).to eq true
      Taro.unfollow(Jiro)
      expect(Taro.following?(Jiro)).to eq false
    end
  end
end
