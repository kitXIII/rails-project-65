# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @another_user = users(:two)
    @admin = users(:admin)

    @attrs = {
      admin: true
    }
  end

  test 'should not get index when user is not logged in' do
    get admin_users_url

    assert_redirected_to root_url
  end

  test 'should not get index when user is not admin' do
    sign_in(@user)
    get admin_users_url

    assert_redirected_to root_url
  end

  test 'should get index when user is admin' do
    sign_in(@admin)
    get admin_users_url

    assert_response :success
  end

  test 'should not get show when user is not logged in' do
    get admin_user_url(@another_user)

    assert_redirected_to root_url
  end

  test 'should not get show when user is not admin' do
    sign_in(@user)
    get admin_user_url(@another_user)

    assert_redirected_to root_url
  end

  test 'should get show when user is admin' do
    sign_in(@admin)
    get admin_user_url(@another_user)

    assert_response :success
  end

  test 'should not get edit when user is not logged in' do
    get edit_admin_user_url(@another_user)

    assert_redirected_to root_url
  end

  test 'should not get edit when user is not admin' do
    sign_in(@user)
    get edit_admin_user_url(@another_user)

    assert_redirected_to root_url
  end

  test 'should get edit when user is admin' do
    sign_in(@admin)
    get edit_admin_user_url(@another_user)

    assert_response :success
  end

  test 'should not update when user is not logged in' do
    patch admin_user_url(@another_user), params: { user: @attrs }

    @another_user.reload

    assert_not @another_user.admin?
    assert_redirected_to root_url
  end

  test 'should not update when user is not admin' do
    sign_in(@user)
    patch admin_user_url(@another_user), params: { user: @attrs }

    @another_user.reload

    assert_not @another_user.admin?
    assert_redirected_to root_url
  end

  test 'should update when user is admin' do
    sign_in(@admin)
    patch admin_user_url(@another_user), params: { user: @attrs }

    @another_user.reload

    assert { @another_user.admin? }
    assert_redirected_to admin_users_url
  end
end
