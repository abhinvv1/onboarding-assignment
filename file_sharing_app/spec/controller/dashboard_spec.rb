require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET #index" do
    context "when user is logged in" do
      let(:user) { create(:user) }

      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to receive(:require_login).and_return(true)
        get dashboard_path
      end

      it "returns a success response" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not logged in" do
      before do
        allow(controller).to receive(:require_login).and_call_original
        get dashboard_path
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
