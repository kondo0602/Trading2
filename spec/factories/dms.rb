FactoryBot.define do
  factory :dm do
    sequence(:content) { |n| "TEST_CONTENT#{n}" }
  end
end
