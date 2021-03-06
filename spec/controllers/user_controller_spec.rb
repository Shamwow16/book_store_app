require 'rails_helper'
RSpec.describe UsersController, :type => :controller do
  describe 'GET #new' do
    it 'returns a successful http request status code' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET #show' do
    it 'returns a successful http request status code' do
      user = Fabricate.create(:user)
      get :show, id: user.id
      expect(response).to have_http_status(:success)
    end
  end



  describe 'POST #create' do
    context 'successful create' do
      it 'saves the new user object' do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it 'redirects to the user show action' do

        post :create, user: Fabricate.attributes_for(:user)

        expect(response).to redirect_to user_path(User.first)
      end

      it 'sets the success flash message' do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success]).to eq('User has been created')
      end
    end

    context 'unsuccessful create' do
      it 'does not save the user object with invalid input' do
        post :create, user: Fabricate.attributes_for(:user, first_name: nil)
        expect(User.count).to eq(0)
      end

      it 'sets the failure flash message' do
        post :create, user: Fabricate.attributes_for(:user, first_name: nil)
        expect(flash.now[:danger]).to eq('User has not been created')
      end
    end
  end
end
