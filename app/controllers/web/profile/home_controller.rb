# frozen_string_literal: true

class Web::Profile::HomeController < Web::Profile::ApplicationController
  def index
    @q = current_user.bulletins
                     .order(updated_at: :desc)
                     .ransack(params[:q])

    @bulletins = @q.result.page(page)
  end
end
