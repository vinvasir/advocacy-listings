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
    return unless user_signed_in?

    unless current_user.respond_to?(:has_consented_cookie?) && current_user.has_consented_cookie?
      c = PolicyManager::Term.where(rule: "cookie").last
      @cookie = c.description if !!c
    end

    unless current_user.respond_to?(:has_consented_age?) && current_user.has_consented_age?
      a = PolicyManager::Term.where(rule: "age").last
      @age = a.description if !!a
    end

    unless current_user.respond_to?(:has_consented_privacy_terms?) && current_user.has_consented_privacy_terms?
      pt = PolicyManager::Term.where(rule: "privacy_terms").last
      @privacy_terms = pt.description if !!pt
    end
  end

  def current_user_has_consented_to_all?
    return false unless current_user

    (current_user.has_consented_cookie? &&
     current_user.has_consented_age? &&
     current_user.has_consented_privacy_terms?)
  end
end
