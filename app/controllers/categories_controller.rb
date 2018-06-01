class CategoriesController < ApplicationController
  def index
    @area = Area.find_by(slug: params[:id])
    @categories = Category.roots
  end
end