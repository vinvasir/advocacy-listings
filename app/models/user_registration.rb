class UserRegistration
  include ActiveModel::Model

  delegate :email, :password, :password_confirmation, :remember_me, to: :user

  attr_accessor :user, :consent_cookie, :consent_age, :consent_privacy_terms

  def initialize(user = User.new, attrs={})
    @user = user
    @user.email = attrs[:email]
    @user.password = attrs[:password]
    @user.password_confirmation = attrs[:password_confirmation]

    @consent_cookie = attrs[:consent_cookie]
    @consent_age = attrs[:consent_age]
    @consent_privacy_terms = attrs[:consent_privacy_terms]
  end

  def save
    @user.save if @user.valid?

    if [consent_cookie, consent_age, consent_privacy_terms].all? {|c| c == "1"}
      @user.pending_policies.each do |c|
        c.terms.each do |term|
          @user.handle_policy_for(term).accept!
        end
      end
    end

    @user.save
  end
end