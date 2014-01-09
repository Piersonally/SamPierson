# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph 10 }
    association :author, factory: :account
  end

  factory :published_article, parent: :article do
    published_at { Time.now }
    visible true
  end
end
