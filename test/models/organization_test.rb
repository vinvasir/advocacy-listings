require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @usa = Area.create!(name: "United States")
    @south = @usa.children.create!(name: "US South")
    @atlanta = @south.children.create!(name: "Atlanta")
    @nashville = @south.children.create!(name: "Nashville")

    cat = Category.create!(name: "some category")

    @fake_atlanta = @atlanta.organizations.create!(title: "Fake Atlanta Org", mission: "idk", category: cat)
    @fake_nashville = @nashville.organizations.create!(title: "Fake Nashville", mission: "idk", category: cat)
  end

  test "scope in_area should return all orgs in an area or its sub-areas" do
    orgs = Organization.in_area(@south)

    assert_includes orgs, @fake_nashville
    assert_includes orgs, @fake_atlanta
  end
end
