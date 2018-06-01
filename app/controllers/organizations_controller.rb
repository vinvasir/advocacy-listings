class OrganizationsController < ApplicationController
  def index
    @category = Category.find_by(slug: params[:category_id])

    @organizations = Organization.in_area(@area).from_category(@category)
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = Organization.find_by(id: params[:id])
  end
end