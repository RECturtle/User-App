require 'rails_helper'

# This set of tests check the user controller
RSpec.describe "Users" do
  
  # test retrieving all users
  describe "GET /users" do
    let!(:user) { create(:user) }
    
    it "contains the user names do" do
      get users_path

      expect(response.body).to include(user.first_name)
    end
    
    it "grabs all users" do
      get users_path

      expect(assigns(:users)).to eq (User.all)
    end
  end
  
  # test creating a user
  describe 'POST create a new user' do
    let!(:user) { create(:user) }
    params = { first_name: 'a', last_name: 'b', email: 'test@email.com', city: 'raleigh', state: 'nc', score: 3}
    empty_params = { first_name: '', last_name: '', email: '', city: '', state: '', score: ''}
        
    it 'accepts and redirects to the new user' do
      post users_path, :params => { :user => params }
      new_user = User.last

      expect(response).to have_http_status(:redirect)      
      expect(response).to redirect_to(user_path(new_user))
      expect(User.last.id).to eql(new_user.id)
    end

    it "throws error messages with blank or invalid params" do
      post users_path, :params => { :user => empty_params }

      expect(response.body).to include("be blank")
      expect(response.body).to include("Email is invalid")
      expect(response.body).to include("Score is not a number")
    end

    it "fails to create a new user with invalid params" do
      post users_path, :params => { :user => empty_params }

      expect(User.last.id).to eql(user.id)
    end
  end

  # test selecting and showing a user
  describe 'GET /users/:id' do
    let!(:user) { create(:user) }

    it 'should grab the user and show full name' do
      get user_path(user)

      expect(response.body).to include(user.first_name)
      expect(response.body).to include("#{user.first_name} #{user.last_name}")
    end
  end

  # test updating a user
  describe 'PUT /users/:id' do
    let!(:user) { create(:user) }
    
    it 'should update the user first_name' do
      put user_path(user), params: { user: { first_name: 'Alice' } }
      user.reload

      expect(user.first_name).to eql('Alice')
    end
  end

  # test deleting a user
  describe 'DELETE /users/:id' do
    let!(:user) { create(:user) }
    
    it 'should delete the user' do
      delete user_path(user)
      
      expect(User.exists?(user.id)).to be false
    end
  end
end
