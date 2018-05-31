class HomeController < ApplicationController
  def index
    @countries = Area.roots
  end
end