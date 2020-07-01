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
  pending "add some examples to (or delete) #{__FILE__}"
end
