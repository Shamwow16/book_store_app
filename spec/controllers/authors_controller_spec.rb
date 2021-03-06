require 'rails_helper'
require 'support/macros'
require 'support/shared_examples'

RSpec.describe AuthorsController, type: :controller do
  let(:admin) { Fabricate(:admin) }
  let(:user) { Fabricate(:user) }

  before { set_current_admin admin }

  describe 'GET #index' do
    context 'guest users' do
      it_behaves_like 'requires sign in' do
        let(:action) { get :index }
      end
    end

    context 'non-admin users' do
      it_behaves_like 'requires admin' do
        let(:action) { get :index }
      end
    end

    context 'admin users' do
      it 'returns a successful http request status code' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    let(:author) { Fabricate.create(:author) }
    before { clear_current_user }

    context 'guest users' do
      it_behaves_like 'requires sign in' do
        let(:action) { get :show, id: user.id }
      end
    end

    context 'non-admin users' do
      it_behaves_like 'requires admin' do
        let(:action) { get :show, id: user.id }
      end
    end

    context 'admin users' do
      before { set_current_admin admin }
      it 'returns a successful http request status code' do
        get :show, id: author.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #new' do
    it 'returns a successful http request status code' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'successful create' do
      it 'saves the new author object' do
        post :create, author: Fabricate.attributes_for(:author)
        expect(Author.count).to eq(1)
      end

      it 'redirects to the author show action' do
        post :create, author: Fabricate.attributes_for(:author)
        expect(response).to redirect_to author_path(Author.first)
      end

      it 'sets the success flash message' do
        post :create, author: Fabricate.attributes_for(:author)
        expect(flash[:success]).to eq('Author has been created')
      end
    end

    context 'unsuccessful create' do
      it 'does not save the author object with invalid input' do
        post :create, author: Fabricate.attributes_for(:author, first_name: nil)
        expect(Author.count).to eq(0)
      end

      it 'sets the failure flash message' do
        post :create, author: Fabricate.attributes_for(:author, first_name: nil)
        expect(flash.now[:danger]).to eq('Author has not been created')
      end
    end
  end

  describe 'GET #edit' do
    let(:author) { Fabricate(:author) }

    it 'sends a successful edit request' do
      get :edit, id: author
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    context 'successful update' do
      let(:john) { Fabricate(:author, first_name: 'John') }
      it 'updates the modified author object' do
        put :update, author: Fabricate.attributes_for(:author, first_name: 'Mike'), id: john.id
        expect(Author.last.first_name).to eq('Mike')
        expect(Author.last.first_name).not_to eq('John')
      end

      it 'sets the success flash message' do
        put :update, author: Fabricate.attributes_for(:author, first_name: 'Mike'), id: john.id
        expect(flash[:success]).to eq('Author has been updated')
      end
      it 'redirects to the show action' do
        put :update, author: Fabricate.attributes_for(:author, first_name: 'Mike'), id: john.id
        expect(response).to redirect_to author_path(Author.last)
      end
    end

    context 'unsuccessful update' do
      let(:john) { Fabricate(:author, first_name: 'John') }
      it 'does not update the author object with invalid inputs' do
        put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id
        expect(Author.last.first_name).to eq('John')
      end

      it 'sets the failure flash message' do
        put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id
        expect(flash.now[:danger]).to eq('Author has not been updated')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:author) { Fabricate(:author) }

    it 'deletes the author with given id' do
      delete :destroy, id: author.id
      expect(Author.count).to eq(0)
    end

    it 'sets the flash message' do
      delete :destroy, id: author.id
      expect(flash[:success]).to eq('Author has been deleted')
    end

    it 'redirects to the index action' do
      delete :destroy, id: author.id
      expect(response).to redirect_to authors_path
    end
  end
end
