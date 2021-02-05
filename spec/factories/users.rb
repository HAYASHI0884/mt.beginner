FactoryBot.define do
  factory :user do
    name                  {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {"000000"}
    password_confirmation {password}

    factory :admin do
      name                  {"admin"}
      email                 {"admin@mail.com"}
      password              {"11111111"}
      password_confirmation {password}
      admin                 {1}
    end
  end
end
