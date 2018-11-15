require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) do
    { title: 'Test Notification',
    	content: 'Test 123',
    	date: Time.now}
  end

  before(:each) do
    user = double('user')
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(user).to receive(:notifications)
  end

  describe 'GET #index' do
  skip 'returns a non-success response to non-logged in user' do
      get :index
      expect(response).not_to be_successful
    end
  end

  describe 'GET #show' do
    skip 'returns a success response' do
      notification = Notification.create! valid_attributes
      get :show, params: { id: notification.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
  skip 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    skip 'returns a success response' do
      notification = Notification.create! valid_attributes
      get :edit, params: { id: notification.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      skip 'creates a new Notification' do
        expect {
          post :create, params: { notification: valid_attributes }
        }.to change(Notification, :count).by(1)
      end
    end
  end
end
