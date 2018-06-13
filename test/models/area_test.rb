require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  def setup
    @usa = FactoryBot.create(:root_area)
    @south = Area.find_by(name: "US South")
    @atlanta = Area.find_by(name: "Atlanta")
    @nashville = Area.find_by(name: "Nashville")
  end

  test "should set a prefixed slug for grandchildren and below of the parent node" do
    assert_equal "united-states", @usa.slug
    assert_equal "us-south", @south.slug
    assert_equal "us-south-atlanta", @atlanta.slug
    assert_equal "us-south-nashville", @nashville.slug
  end
end
