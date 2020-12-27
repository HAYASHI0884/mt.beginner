FactoryBot.define do
  factory :tweet do
    association  :user
    title        {"test"}
    introduction {"test"}

    after(:build) do |tweet|
      tweet.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
