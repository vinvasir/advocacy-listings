require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @health = Category.create!(name: "Health")
    @childhood_cancer = @health.children.create!(name: "Childhood Cancer")

    @diversity = Category.create!(name: "Diversity and Inclusion")
    @racial_justice = @diversity.children.create!(name: "Racial Justice")

    @urban_planning = Category.create!(name: "Urban Planning")

    @transportation = @urban_planning.children.create!(name: "Transportation")
    @public_transit = @transportation.children.new(name: "Public Transit")
    @cycling = @transportation.children.new(name: "Cycling")

    @zoning = @urban_planning.children.create!(name: "Zoning")
    @affordable_housing = @urban_planning.children.create!(name: "Affordable Housing")
  end

  test "should set a prefixed slug for grandchildren and below of the parent node" do
    assert_equal "health", @health.slug
    assert_equal "childhood-cancer", @childhood_cancer.slug

    assert_equal "diversity-and-inclusion", @diversity.slug
    assert_equal "racial-justice", @racial_justice.slug

    assert_equal "urban-planning", @urban_planning.slug
    assert_equal "transportation", @transportation.slug
    assert_equal "transportation-public-transit", @public_transit.slug
    assert_equal "transportation-cycling", @cycling.slug

    assert_equal "zoning", @zoning.slug
    assert_equal "affordable-housing", @affordable_housing.slug
  end

  test "should not allow duplicate slugs" do
    @zoning_2 = Category.new(name: "Zoning")

    assert_not @zoning_2.save
    assert_not @zoning_2.valid?
  end
end
