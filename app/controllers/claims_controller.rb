class ClaimsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_org

  def show
    @claim = Claim.find(params[:id])
  end

  def create
    if !!current_user.claim(@org)
      flash[:success] = "Thank you! We will be in touch as we review your application."
    else
      flash[:error] = "Sorry, you cannot apply to claim this organization at this time."
    end

    redirect_to area_organization_path(current_area, @org)
  end

  def destroy
    current_user.claims.where(organization: @org).destroy_all

    redirect_to area_organization_path(current_area, @org)
  end  

  private

    def set_org
      @org = Organization.find(params[:organization_id])
    end  
end