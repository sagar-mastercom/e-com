require 'rails_helper'

RSpec.describe "User", type: :request do
  let(:user) {create :user}

  before(:each) do
    sign_in(user)
  end
  describe "GET /all_users" do
    it "GET /all_users" do
      get '/all_users'
      expect(response).to have_http_status(200)
    end
  end

  describe 'Create User' do
    it 'should Create user successfully' do
      if user
        sign_in(user)
        expect(response).to be_nil
      end
    end

  end

  describe 'get Current User' do
    it 'should get Current User' do
      get '/current_user'
      expect(response).to have_http_status(200)
    end
  end
end
