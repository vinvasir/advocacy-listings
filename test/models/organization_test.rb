require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @usa = FactoryBot.create(:root_area)
    @south = Area.find_by(name: "US South")

    @cat = Category.create!(name: "some category")
  end

  test "scope in_area should return all orgs in an area or its sub-areas" do
    @atlanta = Area.find_by(name: "Atlanta")
    @nashville = Area.find_by(name: "Nashville")

    @fake_atlanta = @atlanta.organizations.create!(title: "Fake Atlanta Org", mission: "idk", category: @cat)
    @fake_nashville = @nashville.organizations.create!(title: "Fake Nashville", mission: "idk", category: @cat)

    orgs = Organization.in_area(@south)

    assert_includes orgs, @fake_nashville
    assert_includes orgs, @fake_atlanta
    assert_includes Organization.in_area(@usa), @fake_atlanta
    assert_includes Organization.in_area(@usa), @fake_nashville
  end

  test "scope from_category should return all orgs in a category or its sub-categories" do
    @transit = @cat.children.create!(name: "Transit")
    @cycling = @transit.children.create!(name: "Cycling")

    other_cat = Category.create!(name: "Irrelevant")

    fake_org = @cycling.organizations.create!(title: "Fake Org", area: @usa, mission: "wevs")

    assert_includes Organization.from_category(@cat), fake_org
    assert_includes Organization.from_category(@cycling), fake_org
    refute_includes Organization.from_category(other_cat), fake_org
  end
end
