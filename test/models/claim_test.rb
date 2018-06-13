require 'test_helper'

class ClaimTest < ActiveSupport::TestCase
  test "allows users to have claimed_organizations and orgs to have claimants" do
    usa = Area.create!(name: "United States")
    health = Category.create!(name: "Health")

    user_1 = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:user)
    user_3 = FactoryBot.create(:user)


    @org = user_1.submitted_organizations.create!(title: "Some org", mission: "who knows?", area: usa, category: health)

    user_2.claim(@org)
    user_3.claim(@org)

    assert_includes user_2.reload.claimed_organizations, @org
    assert_includes user_3.reload.claimed_organizations, @org
    refute_includes user_1.reload.claimed_organizations, @org
    assert_includes @org.reload.claimants, user_2
    assert_includes @org.reload.claimants, user_3
    refute_includes @org.reload.claimants, user_1
    assert_equal @org.submitter, user_1
    assert_includes user_1.submitted_organizations, @org
  end
end
