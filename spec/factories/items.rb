FactoryBot.define do
  factory :item do
    # association :user
    sequence(:name) { |n| "TEST_NAME#{n}" }
    sequence(:content) { |n| "TEST_CONTENT#{n}" }
    shitagaki { 0 }
    brand { 'nike' }
    size { '26cm' }
    status { '未使用新品' }
  end
end
