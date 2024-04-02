# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @bulletins = Bulletin.published.order(updated_at: :desc)
  end

  def show
    @bulletin = policy_scope(Bulletin).find params[:id]
  end
end
