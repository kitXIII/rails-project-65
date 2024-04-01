# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = policy_scope(User).where(admin: false).order(name: :asc)
    @admins = policy_scope(User).where(admin: true).order(name: :asc)
  end

  def edit
    @user = authorize User.find(params[:id])
  end

  def update
    @user = authorize User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:admin)
  end
end
