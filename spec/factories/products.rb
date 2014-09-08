FactoryGirl.define do
  factory :product do
    name 'SaaS'
    description 'Software as a Service'
    sequence(:cost) { |n| n + 42 }
  end
end