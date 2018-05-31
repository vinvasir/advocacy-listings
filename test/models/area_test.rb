require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  def setup
    @usa = Area.create!(name: "United States")
    @south = @usa.children.create!(name: "US South")
    @atlanta = @south.children.new(name: "Atlanta")
    @nashville = @south.children.new(name: "Nashville")
  end

  test "should set a prefixed slug for grandchildren and below of the parent node" do
    assert_equal "united-states", @usa.slug
    assert_equal "us-south", @south.slug
    assert_equal "us-south-atlanta", @atlanta.slug
    assert_equal "us-south-nashville", @nashville.slug
  end
end
