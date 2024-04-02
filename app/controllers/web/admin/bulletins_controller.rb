# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def publish
    @bulletin = Bulletin.find params[:id]

    notification = if @bulletin.publish!
                     { notice: t('.success') }
                   else
                     { alert: t('.failed') }
                   end

    redirect_back fallback_location: admin_root_path, **notification
  end

  def reject
    @bulletin = Bulletin.find params[:id]

    notification = if @bulletin.reject!
                     { notice: t('.success') }
                   else
                     { alert: t('.failed') }
                   end

    redirect_back fallback_location: admin_root_path, **notification
  end

  def archive
    @bulletin = Bulletin.find params[:id]

    notification = if @bulletin.archive!
                     { notice: t('.success') }
                   else
                     { alert: t('.failed') }
                   end

    redirect_back fallback_location: admin_root_path, **notification
  end
end
