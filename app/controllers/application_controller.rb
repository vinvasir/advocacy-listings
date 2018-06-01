class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_area

  helper_method [:current_area, :has_area]

  def current_area
    return (
      Area.find_by(id: session[:area_id]) || 
      Area.find_by(slug: params[:area_id]) || 
      Area.roots.first
    )
  end

  def has_area?
    return session.has?[:area_id]
  end

  protected

  def set_area
    @area ||= current_area
  end
end
