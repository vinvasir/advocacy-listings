FactoryBot.define do
  factory :root_area, class: Area do
    initialize_with { new(name: "United States") }

    after(:save) do |usa|
      regions = []

      regions << usa.children.new(name: "East Coast")
      regions << usa.children.new(name: "Midwest")
      regions << usa.children.new(name: "US South")
      regions << usa.children.new(name: "West Coast")

      regions.each &:save

      regions[0].children.new(name: "New York City")
      regions[0].children.new(name: "Boston")
      regions[0].children.new(name: "Philadelphia")

      regions[1].children.new(name: "Chicagoland")
      regions[1].children.new(name: "Detroit")
      regions[1].children.new(name: "Indiana")
      regions[1].children.new(name: "Minnesota")
      regions[1].children.new(name: "Ohio")
      regions[1].children.new(name: "Wisconsin")

      regions[2].children.new(name: "Alabama")
      regions[2].children.new(name: "Atlanta")
      regions[2].children.new(name: "Charlotte")
      regions[2].children.new(name: "Louisiana")
      regions[2].children.new(name: "Mississippi")
      regions[2].children.new(name: "Nashville")
      regions[2].children.new(name: "NC Triangle")
      regions[2].children.new(name: "New Orleans")
      regions[2].children.new(name: "Richmond")

      regions[3].children.new(name: "Berkeley")
      regions[3].children.new(name: "Los Angeles")
      regions[3].children.new(name: "Oakland")
      regions[3].children.new(name: "Portland")
      regions[3].children.new(name: "San Diego")
      regions[3].children.new(name: "San Francisco")
      regions[3].children.new(name: "Seattle")
      regions[3].children.new(name: "Silicon Valley")

      regions.each do |region|
        region.children.each &:save
      end
    end
  end
end