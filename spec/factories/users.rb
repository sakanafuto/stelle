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
FactoryBot.define do
  factory :user do
    name { 'TestUser' }
    sequence(:email) { |i| "test#{i}@sample.com" }
    password { 'password' }
  end

  trait :invalid do
    name { '' }
    email { 'test@test' }
    password { 'test' }
  end

  trait :admin do
    name { 'AdminUser' }
    email { 'admin@sample.com' }
    password { 'adminpass' }
    admin { 'true' }
  end

  trait :guest do
    name { 'GuestUser' }
    email { 'guest@sample.com' }
    password { 'guestpass' }
    guest { 'true' }
  end

  trait :with_posts do
    transient do
      posts_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:post, evaluator.posts_count, user: user)
    end
  end
end
