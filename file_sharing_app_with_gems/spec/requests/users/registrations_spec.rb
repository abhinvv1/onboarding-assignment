require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do

  describe "GET /users/sign_up" do
    it "renders the signup page" do
      get "/users/sign_up"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) do
        {
          user: {
            username: "testuser",
            name: "Test User",
            email: "test@example.com",
            password: "Password123",
            password_confirmation: "Password123"
          }
        }
      end

      it "creates a new user" do
        expect {
          post user_registration_path, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "redirects to dashboard with a success notice" do
        post user_registration_path, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Welcome! You have signed up successfully.")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          user: {
            username: "",
            email: "invalid_email",
            name: "",
            password: "short",
            password_confirmation: "different"
          }
        }
      end

      it "does not create a new user" do
        expect {
          post user_registration_path, params: invalid_attributes
        }.not_to change(User, :count)
      end

      it "renders the new template" do
        post user_registration_path, params: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end
end
