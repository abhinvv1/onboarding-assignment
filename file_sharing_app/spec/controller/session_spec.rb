require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET #new" do
    it "renders the new template" do
      get login_path
      expect(response).to render_template(:new)
    end
  end
  describe "POST #create" do
    context "with valid credentials" do
      let!(:user) { create(:user, name:"test user", username: "testuser", password: "Password123") }

      it "logs in the user" do
        post login_path, params: { username: "testuser", password: "Password123" }
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to dashboard with a success notice" do
        post login_path, params: { username: "testuser", password: "Password123" }
        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq('Logged in successfully!')
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to login path with a success notice" do
      get logout_path
      expect(response).to redirect_to(login_path)
      expect(flash[:notice]).to eq('Logged out successfully!')
    end
  end
end
