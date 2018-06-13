require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @user_1 = FactoryBot.create(:user)
    @user_2 = FactoryBot.create(:user)
    @user_3 = FactoryBot.create(:user)

    @org = FactoryBot.build(:organization)
    @user_1.submitted_organizations << @org
  end

  test "allows users to have favorite organizations and orgs to have favoriters" do
    assert @org.persisted?

    @user_2.favorite @org
    @user_1.favorite @org

    assert_includes @org.favoriters, @user_1
    assert_includes @org.favoriters, @user_2

    assert_includes @user_1.favorite_organizations, @org
    assert_includes @user_2.favorite_organizations, @org

    assert_equal @user_1, @org.submitter

    refute_includes @org.favoriters, @user_3
    refute_includes @user_3.favorite_organizations, @org
  end

  test "should not allow duplicate favoriting" do
    @user_3.favorite @org
    @user_3.favorite @org

    assert_equal 1, @user_3.favorites.where(favoritable: @org).count
  end
end