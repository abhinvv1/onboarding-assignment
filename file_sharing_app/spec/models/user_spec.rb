require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(
      username: "testuser",
      email: "test@example.com",
      password: "Password123",
    )
    expect(user).to be_valid
  end

  it "is not valid without a username" do
    user = User.new(username: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with a weak password" do
    user = User.new(password: "password")
    expect(user).to_not be_valid
  end

  it "is not valid with a duplicate username" do
    User.create(username: "testuser", email: "test1@example.com", password: "Password123")
    user = User.new(username: "testuser", email: "test2@example.com", password: "Password123")
    expect(user).to_not be_valid
  end
end