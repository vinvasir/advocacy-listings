module Profile
  class FavoriteOrganizationsController < ProfileController
    def index
      @organizations = current_user.favorite_organizations
    end
  end
end