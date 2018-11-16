require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  include Devise::Test::ControllerHelpers

let(:valid_attributes) do
{
	title: 'Test',
	content: 'Test123',
	date: Time.now
}
end

  describe 'GET #index' do
    it 'returns to new user session' do
      get :index, params: {}
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET #show' do
  	it 'redirects to new user session' do
  		get :show, params: {id: 1}
  		expect(response).to redirect_to(new_user_session_url)
  	end
  end

  describe 'GET #new' do
  	it 'redirects to a new user session' do
  		get :new, params: {}
  		expect(response).to redirect_to(new_user_session_url)
  	end
  end

    describe 'GET #edit' do
  	it 'redirects to a new user session' do
  		get :edit, params: {id: 1}
  		expect(response).to redirect_to(new_user_session_url)
  	end
  end

    describe 'POST #create' do
  	it 'redirects to a new user session' do
  		post :create, params: {}
  		expect(response).to redirect_to(new_user_session_url)
  	end
  end

    describe 'DELETE #destroy' do
  	it 'redirects to a new user session' do
  		delete :destroy, params: {id: 1}
  		expect(response).to redirect_to(new_user_session_url)
  	end
  end

end