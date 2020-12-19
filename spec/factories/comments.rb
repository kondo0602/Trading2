FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "TEST_CONTENT#{n}"}
  end
end
