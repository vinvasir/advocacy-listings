config = PolicyManager::Config.setup do |c|
  c.logout_url = "/users/sign_out"
  c.from_email = "admin@advocacy-db.herokuapp.com"
  c.admin_email_inbox = "prat.vasireddy@gmail.com"

  c.user_resource = User # defaults to User
  c.admin_user_resource = User # defaults to User
  # is_admin method in order for engine to know
  # how to authorize admin only areas
  c.is_admin_method = ->(o){
    o.is_admin?
  }

  c.add_rule({name: "cookie", sessionless: true }  )
  c.add_rule({name: "age", validates_on: [:create, :update], blocking: true })
  c.add_rule({name: "privacy_terms", validates_on: [:create, :update], blocking: true })
end

PolicyManager::UserTermsController.send(:include, Devise::Controllers::Helpers)