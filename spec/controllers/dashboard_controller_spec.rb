require "rails_helper"

RSpec.describe DashboardController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do

    end

    it "renders the index template" do

    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show
      expect(response).to be_success
      expect(response).to have_http_status_code(200)
    end

    it "renders the show template" do
      get :show
      expect(response).to render_template("show")
    end

    it "loads all of the artists into @artists" do
      user = User.new
      artist1 = user.artists.create
      artist2 = user.artists.create
      get :show

      expect(assigns(:artists)).to match_array([artist1, artist2])
    end
  end
end