require "rails_helper"

RSpec.describe AuthorsController, :type => :controller do
  describe "GET #index" do
    it "returns a successful http request status code" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a successful http request status code"  do
      author = Fabricate.create(:author)
      get :show, id: author.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns a successful http request status code" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "successful create" do
      it "saves the new author object" do
        post :create, author: Fabricate.attributes_for(:author)

        expect(Author.count).to eq(1)
      end

      it "redirects to the author show action" do
        post :create, author: Fabricate.attributes_for(:author)
        expect(response).to redirect_to author_path(Author.first)

      end

      it "sets the success flash message" do
        post :create, author: Fabricate.attributes_for(:author)
        expect(flash[:success]).to eq("Author has been created")

      end
    end

    context "unsuccessful create" do

    end
  end
end
