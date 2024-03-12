FactoryBot.define do
  factory :user do
    username { "example_user" }
    email { "user@example4.com" }
    phone { "1234567890" }
    admin { false }
    password { 'password' }
    password_confirmation { 'password' }
    created_at { Time.now }
    updated_at { Time.now }
    confirmed_at { Time.now }
  end
end
