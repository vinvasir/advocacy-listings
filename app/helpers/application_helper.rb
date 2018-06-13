module ApplicationHelper
  def show_cookie_form?(user)
    return false unless is_logged_in? user

    if user.respond_to?(:has_consented_cookie?)
      return true if user.has_consented_cookie?
    end

    false
  end

  def show_age_form?(user)
    return false unless is_logged_in? user

    if user.respond_to?(:has_consented_age?)
      return true if user.has_consented_age?
    end

    false
  end

  def show_privacy_form?(user)
    return false unless is_logged_in? user

    if user.respond_to?(:has_consented_privacy_terms?)
      return true if user.has_consented_privacy_terms?
    end

    false
  end

  def is_logged_in?(user)
    return !!user
  end
end
