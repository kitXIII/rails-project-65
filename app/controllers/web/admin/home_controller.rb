# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.under_moderation.ransack(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?

    @bulletins = @q.result.includes(:user).page(page)
    @categories = Category.order(name: :asc)
  end
end
