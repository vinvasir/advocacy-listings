module Profile
  class OwnOrganizationsController < ProfileController
    def index
      @organizations = current_user.own_organizations
    end
  end
end