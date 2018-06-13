FactoryBot.define do
  factory :root_area, class: Area do
    initialize_with { new(name: "United States") }

    after(:create) do |usa|
      regions = []

      regions << usa.children.create!(name: "East Coast")
      regions << usa.children.create!(name: "Midwest")
      regions << usa.children.create!(name: "US South")
      regions << usa.children.create!(name: "West Coast")

      regions[0].children.create!(name: "NewYork City")
      regions[0].children.create!(name: "Boston")
      regions[0].children.create!(name: "Philadelphia")

      regions[1].children.create!(name: "Chicagoland")
      regions[1].children.create!(name: "Detroit")
      regions[1].children.create!(name: "Indiana")
      regions[1].children.create!(name: "Minnesota")
      regions[1].children.create!(name: "Ohio")
      regions[1].children.create!(name: "Wisconsin")

      regions[2].children.create!(name: "Alabama")
      regions[2].children.create!(name: "Atlanta")
      regions[2].children.create!(name: "Charlotte")
      regions[2].children.create!(name: "Louisiana")
      regions[2].children.create!(name: "Mississippi")
      regions[2].children.create!(name: "Nashville")
      regions[2].children.create!(name: "NC Triangle")
      regions[2].children.create!(name: "New Orleans")
      regions[2].children.create!(name: "Richmond")

      regions[3].children.create!(name: "Berkeley")
      regions[3].children.create!(name: "Los Angeles")
      regions[3].children.create!(name: "Oakland")
      regions[3].children.create!(name: "Portland")
      regions[3].children.create!(name: "San Diego")
      regions[3].children.create!(name: "San Francisco")
      regions[3].children.create!(name: "Seattle")
      regions[3].children.create!(name: "Silicon Valley")
    end
  end
end