require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    it "renders the signup page" do
      get signup_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /signup" do
    context "with valid parameters" do
      let(:valid_params) { { user: { username: "testuser", name:"test user", email: "test@example.com", password: "Password123" } } }

      it "creates a new user" do
        expect {
          post signup_path, params: valid_params
        }.to change(User, :count).by(1)
      end

      it "redirects to dashboard with a success notice" do
        post signup_path, params: valid_params
        expect(response).to redirect_to(dashboard_path)
        follow_redirect!
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { user: { username: "", email: "", password: "" } } }

      it "does not create a new user" do
        expect {
          post signup_path, params: invalid_params
        }.not_to change(User, :count)
      end
    end
  end
end
