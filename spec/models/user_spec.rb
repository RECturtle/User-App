require 'rails_helper'

# This set of tests check the User model
RSpec.describe User, type: :model do
  describe "Test User model method(s)" do
    let(:test_user) { 
      User.new(
        first_name: 'Test',
        last_name: 'Name',
      ) 
    }

    it 'should return the full_name' do
      expect(test_user.full_name).to eql('Test Name')
    end
  end

  describe "Test validations" do
    let(:test_user) {User.new(
      first_name: '',
      last_name: '',
      email: '',
      city: '',
      state: '',
      score: '',
    )}

    it 'validates presence' do
      test_user.validate
      
      expect(test_user.errors[:first_name]).to include("can't be blank")
      expect(test_user.errors[:last_name]).to include("can't be blank")
      expect(test_user.errors[:email]).to include("can't be blank")
      expect(test_user.errors[:city]).to include("can't be blank")
      expect(test_user.errors[:state]).to include("can't be blank")
      expect(test_user.errors[:score]).to include("can't be blank")
    end

    it 'tests rejects invalid formats' do
      test_user.score = 'a'
      test_user.email = 'dud'
      test_user.validate

      expect(test_user.errors[:email]).to include("is invalid")
      expect(test_user.errors[:score]).to include("is not a number")
    end

    it 'accepts a good email' do
      test_user.email = 'test@gmail.com'
      test_user.validate
      expect(test_user.errors[:email]).to eql([])
    end
  end
end

