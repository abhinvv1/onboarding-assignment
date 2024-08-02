require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  describe "GET /users/sign_in" do
    it "renders the login page" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/sign_in" do
    context "with valid credentials" do
      let!(:user) { create(:user) }
      let(:valid_attributes) do
        {
          user: {
            username: user.username,
            password: 'Password123'
          }
        }
      end

      it "logs in the user" do
        post user_session_path, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(controller.current_user).to eq(user)
      end
    end
  end

  describe "Get #destroy" do
    it "redirects to login path with a success notice" do
      get '/users/sign_out'
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Signed out successfully.')
    end
  end
end
