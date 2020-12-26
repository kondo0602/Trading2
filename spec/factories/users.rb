FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    address { '東京' }
    sequence(:password_digest) { User.digest('password') }
  end
end
