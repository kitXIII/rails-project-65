# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.under_moderation
                 .order(updated_at: :desc)
                 .ransack(params[:q])

    @bulletins = @q.result.includes(:user).page(page)
    @categories = Category.order(name: :asc)
  end
end
