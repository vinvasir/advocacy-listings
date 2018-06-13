module Profile
  class ClaimedOrganizationsController < ProfileController
    def index
      @organizations = current_user.pending_claimed_organizations
    end
  end
end