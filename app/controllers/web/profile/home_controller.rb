# frozen_string_literal: true

class Web::Profile::HomeController < Web::Profile::ApplicationController
  def index
    @bulletins = current_user.bulletins.order(updated_at: :desc)
  end
end
