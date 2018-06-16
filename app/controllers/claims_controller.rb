class ClaimsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_org

  def new
    @claim = @org.claims.build(user: current_user)
  end

  def show
    @claim = Claim.find(params[:id])
  end

  def create
    if !!current_user.claim(@org, params[:claim][:application])
      User.admins.each do |admin_user|
        Notification.create(
          recipient: admin_user, 
          actor: current_user, 
          action: "claimed", 
          notifiable: Claim.where(user: current_user, org: @org).first
        )
      end

      flash[:success] = "Thank you! We will be in touch as we review your application."
    else
      flash.now[:error] = "Sorry, something went wrong. Please try again."
      render :new
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