# frozen_string_literal: true

class Web::Profile::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!
end
