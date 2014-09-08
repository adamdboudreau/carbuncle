FactoryGirl.define do
  factory :product do
    name 'SaaS'
    description 'Software as a Service'
    sequence(:cost)
  end
end