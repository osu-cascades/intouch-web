require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) do
    { name: 'Group' }
  end

  let(:invalid_attributes) do
    { name: 'a' * 101 }
  end

  before(:each) do
    user = double('user')
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      group = Group.create! valid_attributes
      get :show, params: { id: group.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      group = Group.create! valid_attributes
      get :edit, params: { id: group.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Group' do
        expect {
          post :create, params: { group: valid_attributes }
        }.to change(Group, :count).by(1)
      end

      it 'redirects to the list of groups' do
        post :create, params: { group: valid_attributes }
        expect(response).to redirect_to(groups_url)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: { group: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'New Group' }
      end

      it 'updates the requested group' do
        group = Group.create! valid_attributes
        put :update, params: { id: group.to_param, group: new_attributes }
        group.reload
        expect(flash[:success]).to eq 'Group updated'
        expect(group.name).to eq 'New Group'
      end

      it 'redirects to the list of groups' do
        group = Group.create! valid_attributes
        put :update, params: { id: group.to_param, group: valid_attributes }
        expect(response).to redirect_to(groups_url)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        group = Group.create! valid_attributes
        put :update, params: { id: group.to_param, group: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested group' do
      group = Group.create! valid_attributes
      expect {
        delete :destroy, params: { id: group.to_param }
      }.to change(Group, :count).by(-1)
    end

    it 'redirects to the list of groups' do
      group = Group.create! valid_attributes
      delete :destroy, params: { id: group.to_param }
      expect(response).to redirect_to(groups_url)
    end
  end
end
