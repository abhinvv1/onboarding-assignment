require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  describe "GET /show" do
    it "returns http success" do
      get "/profiles/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /users/:id" do
    context "with valid parameters" do
      let(:valid_params) { { user: { username: "new_username", name: "New Name", email: "new_email@example.com"} } }

      it "updates the user and redirects to the dashboard" do
        get profiles_update_path(user), params: valid_params
        user.reload
        expect(user.name).to eq("New Name")
        expect(user.email).to eq("new_email@example.com")
        expect(response).to redirect_to(pages_dashboard_path)
        expect(flash[:notice]).to eq('Profile updated successfully')
      end
    end
    context "with invalid parameters" do
      let(:invalid_params) { { user: { email: "invalid_email" } } }

      it "does not update the user and renders the show template" do
        get profiles_update_path(user), params: invalid_params
        user.reload

        expect(user.email).not_to eq("invalid_email")
        expect(response).to render_template(:show)
        expect(flash.now[:alert]).to eq('Failed to update profile')
      end
    end
  end

end
