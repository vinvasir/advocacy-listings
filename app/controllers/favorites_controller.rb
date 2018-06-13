class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_org

  def create
    if !!current_user.claim(@org)
      flash[:success] = "Organization added to your favorites"
    else
      flash[:error] = "Could not add to favorites"
    end

    redirect_to area_organization_path(current_area, @org)
  end

  def destroy
    current_user.favorites.where(favoritable: @org).destroy_all

    redirect_to area_organization_path(current_area, @org)
  end

  private

    def set_org
      @org = Organization.find(params[:organization_id])
    end
end