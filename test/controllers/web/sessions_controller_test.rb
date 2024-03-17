# frozen_string_literal: true

require 'test_helper'

class Web::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'logout' do
    sign_in(@user)

    delete session_url

    assert_response :redirect

    assert_not signed_in?
  end
end
