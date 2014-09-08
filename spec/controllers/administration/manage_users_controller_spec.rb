require 'spec_helper'

describe Administration::ManageUsersController do
  describe "index" do
    context "not logged in" do
      it "redirect" do
        get :index
        response.status.should == 302
      end
    end
    
    context "logged in" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
      end

      it "renders page" do
        get :index
        response.status.should == 200
      end
    end
  end

end