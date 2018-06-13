class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_org

  def create
    if current_user.favorite_organizations << @org
      flash[:success] = "Organization added to your favorites"
    else
      flash[:error] = "Could not add to favorites"
    end

    redirect_to area_organization_path(current_area, @org)
  end

  def destroy
  end

  private

    def set_org
      @org = Organization.find(params[:id])
    end
end