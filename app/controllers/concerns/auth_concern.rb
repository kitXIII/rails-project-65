# frozen_string_literal: true

module AuthConcern
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def signed_in?
    current_user.present?
  end

  def authenticate_user!
    return if signed_in?

    redirect_to root_path, alert: t('flashes.not_logged_in')
  end

  def authenticate_admin!
    return if signed_in? && current_user.admin

    redirect_to root_path, alert: t('flashes.not_authorized')
  end

  def current_user
    return if session[:user_id].blank?

    @current_user ||= User.find_by(id: session[:user_id])
  end
end
