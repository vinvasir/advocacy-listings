class Admin::AdminController < ApplicationController
  before_action :require_admin!

  protected

    def require_admin!
      authenticate_user!

      unless current_user.is_admin?
        flash[:error] = "You are not authorized to perform that action."
        redirect_to root_path
      end
    end
end
