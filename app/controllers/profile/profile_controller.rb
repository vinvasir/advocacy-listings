module Profile
  class ProfileController < ::ApplicationController
    before_action :authenticate_user!
  end
end