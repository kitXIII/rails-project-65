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
    session[:user_id].present? && current_user.present?
  end

  def authenticate_user!
    redirect_to root_path, alert: t('flashes.not_authorized') unless signed_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
