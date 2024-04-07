# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[publish reject archive]

  def index
    @q = Bulletin.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?

    @bulletins = @q.result.includes(:user).page(page)
  end

  def publish
    if @bulletin.may_publish?
      @bulletin.publish!
      redirect_back fallback_location: admin_bulletins_path, notice: t('.success')
    else
      redirect_back fallback_location: admin_bulletins_path, notice: t('.error')
    end
  end

  def reject
    if @bulletin.may_reject?
      @bulletin.reject!
      redirect_back fallback_location: admin_bulletins_path, notice: t('.success')
    else
      redirect_back fallback_location: admin_bulletins_path, notice: t('.error')
    end
  end

  def archive
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_back fallback_location: admin_bulletins_path, notice: t('.success')
    else
      redirect_back fallback_location: admin_bulletins_path, notice: t('.error')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find params[:id]
  end
end
