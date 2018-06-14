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
    
    @user_2.claim(@org, "I have an email under their domain name.")
    @user_3.claim(@org, "I have an email under their domain name.")

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
    @user_1.claim @org, "I have an email under their domain name."

    assert_raise do
      @user_1.claim(@org, "I have an email under their domain name.")
    end
  end

  test "successfully shows pending claims" do
    @user_3.claim @org, "I have an email under their domain name."

    assert_includes @user_3.pending_claimed_organizations, @org
  end

  test "can show whether a user owns an org" do
    @user_2.claim @org, "I have an email under their domain name."
    org_2 = FactoryBot.create(:organization)
    @user_2.claim org_2, "I have an email under their domain name."

    org_3 = FactoryBot.create(:organization)

    Claim.where(user: @user_2, organization: @org).first.update(approved: true)
    Claim.where(user: @user_2, organization: org_2).first.update(approved: true)

    assert_includes @user_2.own_organizations, @org 
    assert_includes @user_2.own_organizations, org_2

    refute_includes @user_2.own_organizations, org_3
    refute_includes @user_2.pending_claimed_organizations, @org
    refute_includes @user_2.pending_claimed_organizations, org_2
  end

  test "can show all organizations that have pending claims" do
    @user_2.claim @org, "I have an email under their domain name."
    org_2 = FactoryBot.create(:organization)
    @user_2.claim org_2, "I have an email under their domain name."

    org_3 = FactoryBot.create(:organization)
    claim_3 = Claim.create!(organization: org_3, user: @user_2, application: "able bable app", approved: true)

    pending_claims = Claim.pending

    assert_includes pending_claims, @org.claims.first
    assert_includes pending_claims, org_2.claims.first
    refute_includes pending_claims, claim_3
  end
end
