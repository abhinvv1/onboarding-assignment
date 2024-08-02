require 'rails_helper'

RSpec.describe UserFile, type: :model do

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user_file)).to be_valid
    end
  end

  describe 'file attachment' do
    it 'is valid with a file attached' do
      user_file = build(:user_file)
      expect(user_file).to be_valid
    end

    it 'is invalid without a file attached' do
      user_file = build(:user_file, file: nil)
      expect(user_file).to be_invalid
      expect(user_file.errors[:file]).to include("can't be blank")
    end
  end

  describe 'name attribute' do
    it 'is invalid with a blank name' do
      user_file = build(:user_file, name: '')
      expect(user_file).to be_invalid
      expect(user_file.errors[:name]).to include("can't be blank")
    end

    it 'is valid with a non-blank name' do
      user_file = build(:user_file, name: 'valid_name.txt')
      expect(user_file).to be_valid
    end

    it 'is not valid with a duplicate name for the same user' do
      user = create(:user)
      create(:user_file, user: user, name: "test.pdf")
      duplicate_file = build(:user_file, user: user, name: "test.pdf")
      expect(duplicate_file).to_not be_valid
      expect(duplicate_file.errors[:name]).to include('File already present')
    end

    it 'is valid with the same name for different users' do
      user1 = create(:user)
      user2 = create(:user)
      create(:user_file, user: user1, name: "test.pdf")
      duplicate_file = build(:user_file, user: user2, name: "test.pdf")
      expect(duplicate_file).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      user = create(:user)
      user_file = create(:user_file, user: user)
      expect(user_file.user).to eq(user)
    end
  end

  describe 'scopes' do
    describe '.latest_first' do
      it 'orders files by created_at in descending order' do
        older_file = create(:user_file, created_at: 2.days.ago)
        newer_file = create(:user_file, created_at: 1.day.ago)
        expect(UserFile.latest_first).to eq([newer_file, older_file])
      end
    end
  end

  describe 'public attribute' do
    it 'defaults to false' do
      user_file = create(:user_file)
      expect(user_file.public).to be false
    end

    it 'can be set to true' do
      user_file = create(:user_file, public: true)
      expect(user_file.public).to be true
    end
  end
end
