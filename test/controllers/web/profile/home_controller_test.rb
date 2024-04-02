# frozen_string_literal: true

require 'test_helper'

class Web::Profile::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should not get profile index, when user is not logged in' do
    get profile_url

    assert_redirected_to root_url
  end

  test 'should get profile index, when user is logged in' do
    sign_in(@user)
    get profile_url

    assert_response :success
  end
end
