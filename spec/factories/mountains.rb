FactoryBot.define do
  factory :mountain do
    association  :area
    association  :elevation
    association  :climb_time
    name          {"test"}

    after(:build) do |mountain|
      mountain.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
