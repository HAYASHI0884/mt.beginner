FactoryBot.define do
  factory :room do
    association  :user
    name         {"test"}
  end
end
