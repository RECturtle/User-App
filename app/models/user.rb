class User < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :city, presence: true
    validates :state, presence: true
    validates :score, presence: true, numericality: { only_integer: true }

    def full_name
        "#{self.first_name} #{self.last_name}"
    end
end

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