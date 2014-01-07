FactoryGirl.define do
  factory :account do
    email
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password 'secret'
    password_confirmation 'secret'
  end

  factory :admin_account, parent: :account do
    roles %w[admin]
  end
end
