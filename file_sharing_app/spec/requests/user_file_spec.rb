require 'rails_helper'

RSpec.describe "UserFiles", type: :request do
  let(:user) { User.create(username: "testuser", email: "testuser@email.com", password: "Password@123") }
  let(:file_data) { double('file_data', original_filename: 'test.txt', size: 1024, content_type: 'text/plain') }

  describe "test callbacks" do
    let(:user_file) { build(:user_file, user: user, file_data: file_data) }

    it "sets default name before validation" do
      user_file.name = nil
      user_file.valid?
      expect(user_file.name).to eq('test.txt')
    end

    it "sets upload date before create" do
      user_file.save
      expect(user_file.upload_date).to eq(Date.today)
    end

    it "generates public URL when made public" do
      user_file.public = true
      user_file.save
      expect(user_file.public_url).to be_present
    end

    it "does not generate public URL when not public" do
      user_file.public = false
      user_file.save
      expect(user_file.public_url).to be_nil
    end
  end
end
