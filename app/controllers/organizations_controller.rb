class OrganizationsController < ApplicationController
  def index
    @category = Category.find_by(slug: params[:category_id])

    @organizations = Organization.in_area(@area).from_category(@category)
  end

  def new
    @organization = Organization.new
  end

  def show
    @organization = Organization.find_by(id: params[:id])
  end

  def create
    @organization = Organization.new(org_params)

    if @organization.save
      flash[:success] = "Organization successfully created"
      redirect_to area_organization_path(@area, @organization)
    else
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
      render :edit
    end
  end

  private

    def org_params
      params.require(:organization).permit(:title, :area_id, :category_id, :mission)
    end
end