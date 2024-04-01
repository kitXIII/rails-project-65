# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    user = find_or_create_user_by(auth)

    sign_in(user) if user.persisted?
    redirect_to root_path, build_user_notification(user)
  end

  def logout
    sign_out
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def find_or_create_user_by(user_info)
    email = user_info[:info][:email].downcase
    name = user_info[:info][:name]

    User.create_with(name:).find_or_create_by(email:)
  end

  def build_user_notification(user)
    if user.persisted?
      { notice: t('successful_login') }
    else
      { alert: user.errors.full_messages.to_sentence }
    end
  end
end
