# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

areas = [
  {
    name: "United States",
    children: [
      {
        name: "East Coast",
        children: [
        ]
      },
      {
        name: "Midwest",
        children: [
        ]
      },
      {
        name: "South",
        children: [
        ]
      },
      {
        name: "West Coast",
        children: [
          {
            name: "Los Angeles"
          }
        ]
      }
    ]
  }
]

areas.each do |country_hash|
  country = Area.create!(name: area_hash[:name])

  area_hash[:children].each do |region_hash|
    region = country.children.create!(name: region_hash[:name])

    region_hash.children.each do |metro_hash|
      metro_area = region.children.create!(name: metro_hash[:name])

    end
  end
end