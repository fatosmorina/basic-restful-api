FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email 'admin@email.com'
    password 'secure_password'
  end
end