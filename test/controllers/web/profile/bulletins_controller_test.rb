# frozen_string_literal: true

require 'test_helper'

class Web::Profile::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins_with_file(:one)
    @author = users(:one)
    @user = users(:two)
  end

  test 'should not to moderate when user is not logged in' do
    patch to_moderate_bulletin_path(@bulletin)

    @bulletin.reload

    assert_not @bulletin.under_moderation?
    assert_redirected_to root_url
  end

  test 'should not to moderate when user is not author' do
    sign_in(@user)
    patch to_moderate_bulletin_path(@bulletin)

    @bulletin.reload

    assert_not @bulletin.under_moderation?
    assert_response :missing
  end

  test 'should to moderate when user is author' do
    sign_in(@author)
    patch to_moderate_bulletin_path(@bulletin)

    @bulletin.reload

    assert { @bulletin.under_moderation? }
    assert_redirected_to profile_path
  end

  test 'should not to moderate when bulletin state is not draft' do
    sign_in(@author)

    %i[archived rejected published].each do |state|
      bulletin = bulletins_with_file(state)

      patch to_moderate_bulletin_path(bulletin)

      bulletin.reload

      assert_not bulletin.under_moderation?
    end
  end

  test 'should not archive when user is not logged in' do
    patch archive_bulletin_path(@bulletin)

    @bulletin.reload

    assert_not @bulletin.archived?
    assert_redirected_to root_url
  end

  test 'should not archive when user is not author' do
    sign_in(@user)
    patch archive_bulletin_path(@bulletin)

    @bulletin.reload

    assert_not @bulletin.archived?
    assert_response :missing
  end

  test 'should archive when user is author' do
    sign_in(@author)
    patch archive_bulletin_path(@bulletin)

    @bulletin.reload

    assert { @bulletin.archived? }
    assert_redirected_to profile_path
  end

  test 'should archive when bulletin in different states' do
    sign_in(@author)

    %i[under_moderation rejected published].each do |state|
      bulletin = bulletins_with_file(state)

      patch archive_bulletin_path(bulletin)

      bulletin.reload

      assert { bulletin.archived? }
    end
  end
end
