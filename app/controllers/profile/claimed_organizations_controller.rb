module Profile
  class ClaimedOrganizationsController < ProfileController
    def index
      @organizations = current_user.claimed_organizations
    end
  end
end