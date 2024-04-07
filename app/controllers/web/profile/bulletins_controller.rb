# frozen_string_literal: true

class Web::Profile::BulletinsController < Web::Profile::ApplicationController
  before_action :set_current_user_bulletin

  def to_moderate
    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_back fallback_location: profile_path, notice: t('.success')
    else
      redirect_back fallback_location: profile_path, notice: t('.error')
    end
  end

  def archive
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_back fallback_location: profile_path, notice: t('.success')
    else
      redirect_back fallback_location: profile_path, notice: t('.error')
    end
  end

  private

  def set_current_user_bulletin
    @bulletin = current_user.bulletins.find params[:id]
  end
end
