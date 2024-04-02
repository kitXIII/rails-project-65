# frozen_string_literal: true

require 'test_helper'

class Web::Profile::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:two)
  end

  test 'should not get profile index, when user not authorized' do
    get profile_root_url

    assert_redirected_to root_url
  end

  test 'should get profile index, when user authorized' do
    sign_in(@user)
    get profile_root_url

    assert_response :success
  end
end
