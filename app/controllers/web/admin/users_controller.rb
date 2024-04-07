# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authorize_user, only: %i[edit update]

  def index
    @q = User.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?

    @users = @q.result.page(page)
  end

  def show; end

  def edit; end

  def update
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

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user
  end
end
