FactoryBot.define do
  factory :organization do
    area
    category

    title { Faker::Company.name }
    mission { Faker::Company.catch_phrase }
    live { Faker::Boolean.boolean }
  end
end
