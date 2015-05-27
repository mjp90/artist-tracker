require "rails_helper"

RSpec.describe HomeController, type: :controller do
  include Devise::TestHelpers
  describe "#index" do
    context "User is not signed in" do
      it "successfully renders index" do
        login_with nil

        get :index
        expect(response).to be_success
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end

    context "User is signed in" do
      it "redirects to the users dashboard" do
        login_with create(:user)
        get :index
        expect(response).to redirect_to(dashboard_show_path)
      end 
    end
  end
end
