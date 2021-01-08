FactoryBot.define do
  factory :item do
    # association :user
    sequence(:name) { |n| "TEST_NAME#{n}" }
    sequence(:content) { |n| "TEST_CONTENT#{n}" }
    shitagaki { 0 }
    brand { 'nike' }
    size { '26cm' }
    status { '未使用新品' }

    # itemがbuildされた後に、itemの画像を紐付ける
    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/files/item1.jpg'), filename: 'item1.jpg')
    end
  end
end
