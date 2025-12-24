FactoryBot.define do
  factory :post do
    association :user
    association :theme
    content { "テスト投稿" }
  end
end
