FactoryBot.define do
  factory :user do
    name  { "テストユーザー_#{SecureRandom.hex(4)}" }
    email { "test_#{SecureRandom.hex(4)}@example.com" }
    password { "password123" }
    provider { "email" }
    uid { SecureRandom.uuid }
  end
end
