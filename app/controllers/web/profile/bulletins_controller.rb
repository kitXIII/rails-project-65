# frozen_string_literal: true

class Web::Profile::BulletinsController < Web::Profile::ApplicationController
  def to_moderate
    @bulletin = current_user.bulletins.find params[:id]

    notification = if @bulletin.to_moderate!
                     { notice: t('.success') }
                   else
                     { alert: t('.failed') }
                   end

    redirect_back fallback_location: profile_path, **notification
  end

  def archive
    @bulletin = current_user.bulletins.find params[:id]

    notification = if @bulletin.archive!
                     { notice: t('.success') }
                   else
                     { alert: t('.failed') }
                   end

    redirect_back fallback_location: profile_path, **notification
  end
end
