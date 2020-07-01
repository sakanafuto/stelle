# == Schema Information
#
# Table name: prefectures
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Prefecture < ApplicationRecord
  has_many :posts
end
