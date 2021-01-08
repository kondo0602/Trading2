FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    address { '宮城' }
    sequence(:password_digest) { User.digest('password') }

    # userがbuildされた後に、userの画像を紐付ける
    after(:build) do |user|
      user.image.attach(io: File.open('spec/fixtures/files/user.jpg'), filename: 'user.jpg')
    end
  end
end
