class CategoriesController < ApplicationController
  def index
    @area = Area.find_by(slug: params[:area_id])
    @categories = Category.roots
  end
end