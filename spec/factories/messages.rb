FactoryBot.define do
  factory :message do
    association  :user
    association  :room
    text         { 'test' }

    after(:build) do |message|
      message.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
