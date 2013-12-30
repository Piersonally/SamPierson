# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph 100 }
    association :author, factory: :account
  end

  factory :published_post, parent: :post do
    published_at { Time.now }
  end
end
