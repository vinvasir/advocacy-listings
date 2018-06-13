require 'test_helper'

class ClaimTest < ActiveSupport::TestCase
  test "allows users to have claimed_organizations and orgs to have claimants" do
    usa = Area.create!(name: "United States")
    health = Category.create!(name: "Health")

    PolicyManager::Term.create!(rule: "cookie", state: "published", description: "whatever")
    PolicyManager::Term.create!(rule: "age", state: "published", description: "whatever")
    PolicyManager::Term.create!(rule: "privacy_terms", state: "published", description: "whatever")

    user_1 = User.new(email: "user@example.com", password: "password", password_confirmation: "password")
    user_2 = User.new(email: "user2@example.com", password: "password", password_confirmation: "password")
    user_3 = User.new(email: "user3@example.com", password: "password", password_confirmation: "password")

    [user_1, user_2, user_3].each do |u| 
      u.pending_policies.each do |c|
        c.terms.each do |term|
          u.handle_policy_for(term).accept!
        end
      end
      u.save
    end


    @org = user_1.submitted_organizations.create!(title: "Some org", mission: "who knows?", area: usa, category: health)

    user_2.claim(@org)
    user_3.claim(@org)

    assert_includes user_2.claimed_organizations, @org
    assert_includes user_3.claimed_organizations, @org
    refute_includes user_1.claimed_organizations, @org
    assert_includes @org.claimants, user_2
    assert_includes @org.claimants, user_3
    refute_includes @org.claimants, user_1
    assert_equal @org.submitter, user_1
    assert_includes user_1.submitted_organizations, @org
  end
end
