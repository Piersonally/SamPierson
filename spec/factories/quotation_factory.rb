# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quotation do
    author { Faker::Name.name }
    quote { Faker::Lorem.sentence }
    association :quoter, factory: :account
  end
end
