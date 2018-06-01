module Session
  class AreasController < ::ApplicationController
    def create
      @area = Area.find_by(slug: params[:slug])

      session[:area_id] = @area.id if @area

      redirect_to area_categories_path(@area)
    end
  end
end