# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.under_moderation.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?

    @bulletins = @q.result.includes(:author)
  end
end
