require 'test_helper'

class CategorySeederTest < ActiveSupport::TestCase
  def setup
    @seed_data = [
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
  end


  test "should create countries, regions, and metro areas" do
    CategorySeeder.new(@seed_data).run

    @urban_planning = Category.find_by(name: "Urban Planning")
    @health = Category.find_by(name: "Health")
    @gender_discrimination = Category.find_by(slug: "gender-identity-workplace-discrimination")
    @race_discrimination = Category.find_by(slug: "racial-justice-workplace-discrimination")
    @transportation = Category.find_by(name: "Transportation")
    @walkability = Category.find_by(name: "Walkability")

    assert @urban_planning.is_root?
    assert @health.is_root?
    assert @gender_discrimination.valid?
    assert @race_discrimination.valid?
    assert_equal @urban_planning.id, @transportation.parent_id
    assert_equal @transportation.id, @walkability.parent_id
    assert_equal @urban_planning.id, @walkability.parent.parent_id
  end
end