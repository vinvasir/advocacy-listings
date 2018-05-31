require 'test_helper'

class AreaSeederTest < ActiveSupport::TestCase
  def setup
    @seed_data = [
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
  end


  test "should create countries, regions, and metro areas" do
    AreaSeeder.new(@seed_data).run

    @usa = Area.find_by(name: "United States")
    @midwest = Area.find_by(name: "Midwest")
    @west_coast = Area.find_by(name: "West Coast")
    @los_angeles = Area.find_by(name: "Los Angeles")

    assert @usa.is_root?
    assert_not @midwest.is_root?
    assert_equal @usa.id, @midwest.parent_id
    assert_equal @west_coast.id, @los_angeles.parent_id
    assert_equal @usa.id, @west_coast.parent_id
  end
end