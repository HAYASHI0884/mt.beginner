FactoryBot.define do
  factory :mountain do
    name          {"test"}
    area_id       {1}
    elevation_id  {1}
    climb_time_id {1}

    after(:build) do |mountain|
      mountain.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
