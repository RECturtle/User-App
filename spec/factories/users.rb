# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  city       :string
#  state      :string
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
    factory :user do
        first_name { "Test" }
        last_name { "User" }
        email { "test@user.com" }
        city { "madison" }
        state { "WI" }
        score { 1 }
    end
end
