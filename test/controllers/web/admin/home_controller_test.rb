# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:admin)
  end

  test 'should not get index when user not authorized' do
    get admin_root_url

    assert_redirected_to root_url
  end

  test 'should not get index when user is not admin' do
    sign_in(@user)
    get admin_root_url

    assert_redirected_to root_url
  end

  test 'should get index when user is admin' do
    sign_in(@admin)
    get admin_root_url

    assert_response :success
  end
end
