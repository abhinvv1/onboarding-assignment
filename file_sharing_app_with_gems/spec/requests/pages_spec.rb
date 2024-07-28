require 'rails_helper'

RSpec.describe "Pages", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  describe "GET /home" do
    it "returns http success" do
      get "/pages/home"
      expect(response).to redirect_to(pages_dashboard_path)
    end
  end

  describe "GET /dashboard" do
    it "returns http success" do
      get "/pages/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
