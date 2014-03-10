# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slide_show do
    title { Faker::Lorem.sentence }
    theme { SlideShow::THEMES.sample }
    content { Faker::Lorem.paragraph 10 }
    association :author, factory: :account
  end
end
