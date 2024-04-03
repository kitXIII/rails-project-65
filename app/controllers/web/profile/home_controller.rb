# frozen_string_literal: true

class Web::Profile::HomeController < Web::Profile::ApplicationController
  def index
    @q = current_user.bulletins.ransack(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?

    @bulletins = @q.result
  end
end
