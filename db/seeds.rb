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
          {
            name: "Boston"
          },
          {
            name: "Buffalo"
          },
          {
            name: "Maine"
          },
          {
            name: "New York City"
          },
          {
            name: "Pittsburgh"
          },
          {
            name: "Rhode Island"
          }
        ]
      },
      {
        name: "Midwest",
        children: [
          {
            name: "Chicago"
          },
          {
            name: "Cleveland"
          },
          {
            name: "Columbus"
          },
          {
            name: "Michigan"
          },
          {
            name: "Milwaukee"
          },
          {
            name: "Minnesota"
          },
          {
            name: "Omaha"
          }
        ]
      },
      {
        name: "South",
        children: [
          {
            name: "Atlanta"
          },
          {
            name: "Austin"
          },
          {
            name: "Miami"
          },
          {
            name: "Nashville"
          },
          {
            name: "New Orleans"
          },
          {
            name: "St. Louis"
          }
        ]
      },
      {
        name: "West Coast",
        children: [
          {
            name: "California"
          },
          {
            name: "Bay Area"
          },
          {
            name: "Colorado"
          },
          {
            name: "Nevada"
          },
          {
            name: "Oregon"
          },
          {
            name: "Seattle"
          },
          {
            name: "San Diego"
          },
          {
            name: "Los Angeles"
          }
        ]
      }
    ]
  }
]

categories = [
  {
    name: "Diversity and Inclusion",
    children: [
      {
        name: "Racial Justice",
        children: [
          {
            name: "Workplace Discrimination"
          },
          {
            name: "Educational Equity"
          },
          {
            name: "Immigration Policy"
          }
        ]
      },
      {
        name: "Gender Identity",
        children: [
          {
            name: "Workplace Discrimination"
          }
        ]
      }
    ]
  },
  {
    name: "Urban Planning",
    children: [
      {
        name: "Transportation",
        children: [
          {
            name: "Public Transit"
          },
          {
            name: "Cycling"
          },
          {
            name: "Walkability"
          }
        ]
      },
      {
        name: "Zoning",
        children: [
        ]
      },
      {
        name: "Housing",
        children: [
          {
            name: "Affordable Housing"
          },
          {
            name: "Homelessness"
          }
        ]
      }
    ]
  },
  {
    name: "Health",
    children: [
      {
        name: "Childhood Cancer",
        children: [
          {
            name: "Bills / Expenses"
          },
          {
            name: "Emotional Support"
          },
          {
            name: "Travel for Treatment"
          }
        ]
      },

    ]
  }
]

AreaSeeder.new(areas).run
CategorySeeder.new(categories).run