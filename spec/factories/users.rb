FactoryBot.define do
  factory :user do
    name { "test_user" }
    email {"testuser@example.com"}
    password { "password123" }
    provider { "email" }
    uid { SecureRandom.uuid }
  end
end