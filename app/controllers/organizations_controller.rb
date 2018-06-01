class OrganizationsController < ApplicationController
  def index
    @area = Area.find_by(slug: params[:area_id])
    @category = Category.find_by(slug: params[:category_id])

    @organizations = Organization.in_area(@area).from_category(@category)
  end
end