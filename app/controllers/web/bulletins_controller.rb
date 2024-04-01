# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @bulletins = Bulletin.published.order(created_at: :desc)
  end

  def show
    @bulletin = policy_scope(Bulletin).find params[:id]
  end
end
