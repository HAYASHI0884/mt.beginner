FactoryBot.define do
  factory :user do
    name                  {"test"}
    email                 {Faker::Internet.free_email}
    password              {"000000"}
    password_confirmation {password}
  end
  factory :admin do
    name                  {"admin"}
    email                 {admin@mail.com}
    password              {"11111111"}
    password_confirmation {password}
  end
end
