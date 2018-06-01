class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_area
  before_action :set_policies

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

  def set_policies
    return unless current_user

    unless current_user.has_consented_cookie?
      @cookie = PolicyManager::Term.where(rule: "cookie").last.description
    end

    unless current_user.has_consented_age?
      @age = PolicyManager::Term.where(rule: "age").last.description
    end

    unless current_user.has_consented_privacy_terms?
      @privacy_terms = PolicyManager::Term.where(rule: "privacy_terms").last.description
    end
  end

  def current_user_has_consented_to_all?
    return unless current_user

    (current_user.has_consented_cookie? &&
     current_user.has_consented_age? &&
     current_user.has_consented_privacy_terms?)
  end
end
