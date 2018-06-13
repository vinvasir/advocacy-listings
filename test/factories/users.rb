FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    after(:build) do |user|
      PolicyManager::Term.create!(rule: "cookie", state: "published", description: "whatever")
      PolicyManager::Term.create!(rule: "age", state: "published", description: "whatever")
      PolicyManager::Term.create!(rule: "privacy_terms", state: "published", description: "whatever") 
    end

    after(:create) do |user|
      user.pending_policies.each do |c|
        c.terms.each do |term|
          user.handle_policy_for(term).accept!
        end
      end
      user.save
    end
  end
end