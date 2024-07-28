FactoryBot.define do
  factory :user_file do
    name { "test.pdf" }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'files', 'test.pdf'), 'application/pdf') }
    association :user
  end
end