require 'rails_helper'

RSpec.describe UserFile, type: :model do
  let(:user) { create(:user) }
  let(:file_data) { double('file_data', original_filename: 'test.txt', size: 1024, content_type: 'text/plain') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      user_file = UserFile.new(user: user, name: 'test.txt', file_data: file_data)
      expect(user_file).to be_valid
    end

    it 'is valid without a name uses default file_name as name param' do
      user_file = UserFile.new(user: user, file_data: file_data)
      expect(user_file).to be_valid
      expect(user_file.name).to be_eql("test.txt")
    end

    it 'is not valid without file_data' do
      user_file = UserFile.new(user: user, name: 'test.txt')
      expect(user_file).to_not be_valid
    end

    it 'is not valid with a duplicate name for the same user' do
      UserFile.create(user: user, name: 'test.txt', file_data: file_data)
      duplicate_file = UserFile.new(user: user, name: 'test.txt', file_data: file_data)
      expect(duplicate_file).to_not be_valid
      expect(duplicate_file.errors[:name]).to include('File already present')
    end

    it 'is valid with the same name for different users' do
      user1 = create(:user)
      user2 = create(:user)
      UserFile.create(user: user1, name: 'test.txt', file_data: file_data)
      duplicate_file = UserFile.create(user: user2, name: 'test.txt', file_data: file_data)
      expect(duplicate_file).to be_valid
    end
  end
end
