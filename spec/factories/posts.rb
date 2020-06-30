FactoryBot.define do
  factory :post do
    name { "MyString" }
    caption { "MyText" }
    image { "MyString" }
    user { nil }
    prefecture { nil }
  end
end
