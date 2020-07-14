# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CSVROW_PREFID = 1
CSVROW_PREFNAME = 2

CSV.foreach('db/csv/prefectures.csv') do |row|
  prefecture_id = row[CSVROW_PREFID]
  prefecture_name = row[CSVROW_PREFNAME]

  Prefecture.find_or_create_by(name: prefecture_name)
end


# ゲストユーザーの作成
User.create!(
  name: "ゲスト太郎",
  email: "guest@example.com",
  password: "guestpass",
  password_confirmation: "guestpass",
  guest: true
)

guest_user = User.find_by(guest: true)
guest_user.avatar = open("#{Rails.root}/db/fixtures/avatar/image-0.jpg")
guest_user.save

# 一般ユーザーの作成
20.times do |i|
  name  = Faker::Name.name
  email = Faker::Internet.email
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

# プロフィール画像を渡す
users = User.where.not(admin: true, guest: true).order(:id).take(15)
users.each_with_index do |user, i|
  user.avatar = open("#{Rails.root}/db/fixtures/avatar/image-#{i + 1}.jpg")
  user.save
end

users = User.all
user_array = [users.find(1), users.find(2), users.find(3), users.find(4), users.find(5)]
user_array.each_with_index do |user, i|
  following = users[i + 2..i + 40]
  followers = users[i + 3..i + 30]
  following.each { |followed| user.follow(followed) }
  followers.each { |follower| follower.follow(user) }
end


# ゲストユーザーのStelle(Post)の作成
guest_user_posts = [
  {
    name: "名古屋港のトワイライト",
    prefecture_id: 23,
    caption: "名古屋においでよ",
    image: "#{Rails.root}/db/fixtures/stelle/nagoyako.jpg"
  },
  {
    name: "お城",
    prefecture_id: 23,
    caption: "金のシャチホコが見えます！",
    image: "#{Rails.root}/spec/fixtures/image.jpg"
  },
  {
    name: "矢代の海",
    prefecture_id: 18,
    caption: "SUPボードに乗ってみたい人は是非！！！",
    image: "#{Rails.root}/db/fixtures/stelle/yashiro.jpg"
  }
]

guest_user_posts.each_with_index do |post, n|
  name = guest_user_posts[n][:name]
  prefecture_id = guest_user_posts[n][:prefecture_id]
  caption = guest_user_posts[n][:caption]
  image = guest_user_posts[n][:image]
  guest_user.posts.create!(
    name: name,
    prefecture_id: prefecture_id,
    caption: caption,
    image: open(image)
  )
end

# 一般ユーザーのStelle(Post)の作成
user_posts = [
  {
    name: "原生のブナ林",
    prefecture_id: 2,
    caption: "白神山地のブナ散策道。自然を楽しめます。",
    image: "#{Rails.root}/db/fixtures/stelle/shirakamisanchi.jpg"
  },
  {
    name: "大泉が池",
    prefecture_id: 3,
    caption: "平安時代から歴史が続く浄土庭園です！秋は紅葉もキレイ！！",
    image: "#{Rails.root}/db/fixtures/stelle/moutsuji.jpg"
  },
  {
    name: "知床の絶景",
    prefecture_id: 1,
    caption: "北海道の世界自然遺産、知床の絶景をどうぞ！",
    image: "#{Rails.root}/db/fixtures/stelle/shiretoko.jpg"
  },
  {
    name: "見ザル言わザル聞かザル",
    prefecture_id: 9,
    caption: "三猿で有名な東照宮は日光の社寺の構成資産として世界遺産に登録されているんですよ〜",
    image: "#{Rails.root}/db/fixtures/stelle/toshogu.jpg"
  },
  {
    name: "地獄の門",
    prefecture_id: 13,
    caption: "国立西洋美術館へ足を運べば日本にいながらも西洋のブロンズ像を見ることができます。",
    image: "#{Rails.root}/db/fixtures/stelle/jigokunomon.jpg"
  },
  {
    name: "山中湖と富士山",
    prefecture_id: 19,
    caption: "富士五湖のなかでも一番大きい！",
    image: "#{Rails.root}/db/fixtures/stelle/yamanakako.jpg"
  },
  {
    name: "春日大社の門",
    prefecture_id: 29,
    caption: "燈籠きれい！",
    image: "#{Rails.root}/db/fixtures/stelle/kasugataisha.jpg"
  },
  {
    name: "合掌造り",
    prefecture_id: 21,
    caption: "冬に観光するのががおすすめです！！飛騨高山や下呂温泉も一緒にどうぞ！。",
    image: "#{Rails.root}/db/fixtures/stelle/shirakawago.jpg"
  },
  {
    name: "富岡製糸場",
    prefecture_id: 10,
    caption: "木骨レンガ造りがオシャレだ",
    image: "#{Rails.root}/db/fixtures/stelle/tomiokaseishijo.jpg"
  },
  {
    name: "ほっきじ！",
    prefecture_id: 29,
    caption: "コスモス畑がめっちゃキレイだ",
    image: "#{Rails.root}/db/fixtures/stelle/hokkiji.jpg"
  },
  {
    name: "紅葉と清水の舞台",
    prefecture_id: 26,
    caption: "この世界遺産はいい写真が多すぎて選ぶのが大変でした！",
    image: "#{Rails.root}/db/fixtures/stelle/kiyomizudera.jpg"
  },
  {
    name: "一の滝",
    prefecture_id: 30,
    caption: "那智大滝は見るべき！",
    image: "#{Rails.root}/db/fixtures/stelle/nachinotaki.jpg"
  },
  {
    name: "姫路城",
    prefecture_id: 28,
    caption: "白漆喰がセクシーな白鷺城",
    image: "#{Rails.root}/db/fixtures/stelle/himejijo.jpg"
  },
  {
    name: "坑道「龍源寺間歩」",
    prefecture_id: 32,
    caption: "石見銀山の600ｍもある坑道です。",
    image: "#{Rails.root}/db/fixtures/stelle/ryugenjimabu.jpg"
  },
  {
    name: "東廻廊から見える大鳥居",
    prefecture_id: 34,
    caption: "厳島神社です。",
    image: "#{Rails.root}/db/fixtures/stelle/itsukushimajinja.jpg"
  },
  {
    name: "有明海に沈む床路",
    prefecture_id: 43,
    caption: "潮が引いたときに見ることが出来ます。雲仙普賢岳もここから見れますよ。",
    image: "#{Rails.root}/db/fixtures/stelle/nagabetakaishoro.jpg"
  }
]

# Posts
users = User.where.not(admin: true, guest: true).take(user_posts.length)
users.each_with_index do |user, n|
  name = user_posts[n][:name]
  prefecture_id = user_posts[n][:prefecture_id]
  caption = user_posts[n][:caption]
  image = user_posts[n][:image]
  user.posts.create!(
    name: name,
    prefecture_id: prefecture_id,
    caption: caption,
    image: open(image)
  )
end

posts = Post.all
posts.each do |post|
  max_user = rand(1..20)
  users = User.all.shuffle.take(max_user)
  users.each do |user|
    post.like(user)
  end
end

# 管理ユーザーの作成
admin = User.create!(
  name: "管理ユーザー",
  email: "admin@example.com",
  password:              "adminpass",
  password_confirmation: "adminpass",
  admin: true
)