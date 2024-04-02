# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:admin)
    @bulletin = bulletins_with_file(:under_moderation)
  end

  test 'should not get index when user not authorized' do
    get admin_bulletins_url

    assert_redirected_to root_url
  end

  test 'should not get index when user is not admin' do
    sign_in(@user)
    get admin_bulletins_url

    assert_redirected_to root_url
  end

  test 'should get index when user is admin' do
    sign_in(@admin)
    get admin_bulletins_url

    assert_response :success
  end

  test 'should not publish when user is not logged in' do
    patch publish_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert_not @bulletin.published?
    assert_redirected_to root_url
  end

  test 'should not publish when user is not admin' do
    sign_in(@user)
    patch publish_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert_not @bulletin.published?
    assert_redirected_to root_url
  end

  test 'should publish when user is admin' do
    sign_in(@admin)

    patch publish_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert { @bulletin.published? }
  end

  test 'should not publish when bulletin state is not under_moderation' do
    sign_in(@admin)

    %i[draft archived rejected].each do |state|
      bulletin = bulletins_with_file(state)

      patch publish_admin_bulletin_url(bulletin)

      bulletin.reload

      assert_not bulletin.published?
    end
  end

  test 'should not reject when user is not logged in' do
    patch reject_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert_not @bulletin.rejected?
    assert_redirected_to root_url
  end

  test 'should not reject when user is not admin' do
    sign_in(@user)
    patch reject_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert_not @bulletin.rejected?
    assert_redirected_to root_url
  end

  test 'should reject when user is admin' do
    sign_in(@admin)

    patch reject_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert { @bulletin.rejected? }
  end

  test 'should not reject when bulletin state is not under_moderation' do
    sign_in(@admin)

    %i[draft archived published].each do |state|
      bulletin = bulletins_with_file(state)

      patch reject_admin_bulletin_url(bulletin)

      bulletin.reload

      assert_not bulletin.rejected?
    end
  end

  test 'should not archive when user is not logged in' do
    patch archive_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert_not @bulletin.archived?
    assert_redirected_to root_url
  end

  test 'should not archive when user is not admin' do
    sign_in(@user)
    patch archive_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert_not @bulletin.archived?
    assert_redirected_to root_url
  end

  test 'should archive when user is admin' do
    sign_in(@admin)

    %i[draft under_moderation rejected published].each do |state|
      bulletin = bulletins_with_file(state)

      patch archive_admin_bulletin_url(bulletin)

      bulletin.reload

      assert { bulletin.archived? }
    end
  end
end
