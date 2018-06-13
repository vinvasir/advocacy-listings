FactoryBot.define do
  factory :category do
    initialize_with { new(name: Faker::Company.industry) }
  end
end