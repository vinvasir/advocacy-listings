class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method [:current_area, :has_area]

  def current_area
    return Area.find_by(id: session[:area_id])
  end

  def has_area?
    return session.has?[:area_id]
  end
end
