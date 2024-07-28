require 'rails_helper'

RSpec.describe "Files", type: :request do
  let(:user) { create(:user) }
  let(:file) { fixture_file_upload('spec/support/files/test.pdf', 'application/pdf') }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders the index page" do
      get files_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /files/new" do
    it "renders the new page" do
      get new_file_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /files" do
    context "with valid parameters" do
      let(:valid_attributes) { { user_file: { name: "Test File", file: file } } }

      it "creates a new file" do
        expect {
          post files_path, params: valid_attributes
        }.to change(UserFile, :count).by(1)
      end

      it "redirects to the files index" do
        post files_path, params: valid_attributes
        expect(response).to redirect_to(files_path)
      end
    end
  end

  describe "GET /files/:id/download" do
    let!(:user_file) { create(:user_file, user: user) }

    it "downloads the file" do
      get download_file_path(user_file)
      expect(response).to have_http_status(:success)
      expect(response.headers['Content-Type']).to eq user_file.file.content_type
      expect(response.headers['Content-Disposition']).to include "filename=\"#{user_file.name}\""
    end
  end

  describe "POST /files/:id/toggle_public" do
    let!(:user_file) { create(:user_file, user: user, public: false) }

    it "toggles the public status of the file" do
      expect {
        post toggle_public_file_path(user_file)
        user_file.reload
      }.to change(user_file, :public).from(false).to(true)
    end

    it "redirects to the files index" do
      post toggle_public_file_path(user_file)
      expect(response).to redirect_to(files_path)
    end
  end
end
