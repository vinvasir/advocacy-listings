require 'test_helper'

class ClaimTest < ActiveSupport::TestCase
  def setup
    @user_1 = FactoryBot.create(:user)
    @user_2 = FactoryBot.create(:user)
    @user_3 = FactoryBot.create(:user)

    @org = FactoryBot.build(:organization)
  end

  test "allows users to have claimed_organizations and orgs to have claimants" do
    @user_1.submitted_organizations << @org
    
    @user_2.claim(@org)
    @user_3.claim(@org)

    assert_includes @user_2.reload.claimed_organizations, @org
    assert_includes @user_3.reload.claimed_organizations, @org
    refute_includes @user_1.reload.claimed_organizations, @org
    assert_includes @org.reload.claimants, @user_2
    assert_includes @org.reload.claimants, @user_3
    refute_includes @org.reload.claimants, @user_1
    assert_equal @org.submitter, @user_1
    assert_includes @user_1.submitted_organizations, @org
  end

  test "should not allow one user to claim an org multiple times" do
    @user_1.claim @org

    assert_raise do
      @user_1.claim(@org)
    end
  end
end
