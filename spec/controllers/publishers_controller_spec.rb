require "rails_helper"

RSpec.describe PublishersController, :type => :controller do
  describe "GET #index" do
    before {get :index}
    it{should respond_with(:success)}
  end

  describe "GET #show" do
    before {
      publisher = Fabricate(:publisher)
      get :show, id:publisher.id
    }

    it {should respond_with(:success)}
  end

  describe "GET #new" do
    before {get :new}
    it{should respond_with(:success)}
  end

  describe "POST #create" do
    context "when publisher creation is successful" do

      before {
        post :create, publisher: Fabricate.attributes_for(:publisher)
      }

      it "should save the new publisher" do
        expect(Publisher.count).to eq(1)
      end

      it {should set_flash[:success] }

      it {should redirect_to(publisher_path(Publisher.first))}



    end
    context "when publisher creation is unsuccessful" do
      before {
        post :create, publisher: Fabricate.attributes_for(:publisher, name:nil)
      }

      it "should not save the new publisher" do
        expect(Publisher.count).to eq(0)
      end

      it {should set_flash[:danger]}
    end
  end

  describe "GET #edit" do
    let(:publisher) {Fabricate(:publisher)}
    before {

      get :edit, id: publisher.id
    }

    it{should respond_with(:success)}
  end

  describe "PUT #update" do
    context "when publisher is updated" do
      let(:harper) {Fabricate(:publisher, name: "Harper Collins")}


      it "should update the publisher name" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: "Penguin"), id: harper.id

        expect(Publisher.last.name).to eq("Penguin")
      end

      it "sets the success flash message" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: "Penguin"), id: harper.id

        expect(flash[:success]).to eq("Publisher has been updated")
      end

      it "redirects to the show action" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: "Penguin"), id: harper.id
        expect(response).to redirect_to publisher_path(Publisher.last)
      end
    end
    context "when publisher is not updated" do
      let(:harper) {Fabricate(:publisher, name: "Harper Collins")}

      it "should not update the publisher name when invalid input" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: nil), id: harper.id
        expect(Publisher.last.name).to eq("Harper Collins")
      end

      it "should set a danger flash" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: nil), id: harper.id
        expect(flash[:danger]).to eq("Publisher was not updated")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:publisher) {Fabricate(:publisher)}

    it "should delete the publisher object" do
      delete :destroy, id: publisher.id
      expect(Publisher.count).to eq(0)
    end

    it "should trigger success flash" do
      delete :destroy, id: publisher.id
      expect(flash[:success]).to eq('Publisher destroyed')
    end

    it "should redirect to the index action" do
      delete :destroy, id: publisher.id
      expect(response).to redirect_to publishers_path
    end

  end
end
