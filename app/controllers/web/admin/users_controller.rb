# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.where(admin: false).order(name: :asc)
    @admins = User.where(admin: true).order(name: :asc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user

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
