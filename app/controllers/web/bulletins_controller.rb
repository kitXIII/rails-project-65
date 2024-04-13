# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update to_moderate archive]
  before_action :set_current_user_bulletin, only: %i[edit update to_moderate archive]

  def index
    @q = Bulletin.published
                 .order(updated_at: :desc)
                 .ransack(params[:q])

    @bulletins = @q.result.page(page)
    @categories = Category.order(name: :asc)
  end

  def show
    @bulletin = policy_scope(Bulletin).find params[:id]
  end

  def new
    @bulletin = Bulletin.new
    authorize @bulletin
  end

  def edit
    authorize @bulletin

    redirect_to profile_path, notice: t('.cant_edit') unless @bulletin.may_be_edited?
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin

    if @bulletin.save
      redirect_to profile_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @bulletin

    unless @bulletin.may_be_edited?
      redirect_to profile_path, notice: t('.cant_edit')
      return
    end

    if @bulletin.update(bulletin_params)
      redirect_to profile_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    authorize @bulletin

    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_back fallback_location: profile_path, notice: t('.success')
    else
      redirect_back fallback_location: profile_path, notice: t('.error')
    end
  end

  def archive
    authorize @bulletin

    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_back fallback_location: profile_path, notice: t('.success')
    else
      redirect_back fallback_location: profile_path, notice: t('.error')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end

  def set_current_user_bulletin
    @bulletin = current_user.bulletins.find params[:id]
  end
end
