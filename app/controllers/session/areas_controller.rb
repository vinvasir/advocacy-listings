module Session
  class AreasController < ::ApplicationController
    def create
      @area = Area.find_by(id: params[:id])

      session[:area_id] = @area.id if @area

      redirect_to categories_path(@area)
    end
  end
end