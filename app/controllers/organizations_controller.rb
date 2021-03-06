class OrganizationsController < ApplicationController
  def index
    @category = Category.find_by(slug: params[:id])

    @organizations = Organization.in_area(@area).from_category(@category)
  end

  def new
    @organization = Organization.new
  end

  def show
    @organization = Organization.find_by(id: params[:id])

    if !!current_user
      @favorite = Favorite.where(favoritable: @organization, user: current_user).first
      @claim = Claim.where(organization: @organization).first
    end

    respond_to do |f|
      f.html {  }
      f.json { render jsonapi: @organization }
    end
  end

  def create
    @organization = Organization.new(org_params)

    if current_user_has_consented_to_all?
      @organization.submitter = current_user
    end

    if @organization.save
      flash[:success] = "Organization successfully created"
      redirect_to area_organization_path(@area, @organization)
    else
      flash.now[:error] = "Something went wrong."
      render :new
    end
  end

  def edit
    @organization = Organization.find_by(id: params[:id])
  end

  def update
    @organization = Organization.find_by(id: params[:id])

    if @organization.update(org_params)
      flash[:success] = "Organization successfully updated"
      redirect_to area_organization_path(@area, @organization)
    else
      flash.now[:error] = "Something went wrong."
      render :edit
    end
  end

  private

    def org_params
      params.require(:organization).permit(:title, :area_id, :category_id, :mission)
    end
end