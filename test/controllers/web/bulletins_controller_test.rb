# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  setup do
    @published_bulletin = bulletins(:published)
    @bulletin = bulletins_with_file(:one)
    @author = users(:one)
    @user = users(:two)
    @admin = users(:admin)

    @attrs = {
      title: Faker::Book.title,
      description: Faker::Books::Dune.quote,
      category_id: categories(:one).id,
      image: fixture_file_upload('one.jpg', 'image/jpg')
    }
  end

  test 'should get index' do
    get root_url

    assert_response :success
  end

  test 'should get show when bulletin is published' do
    get bulletin_url(@published_bulletin)

    assert_response :success
  end

  test 'should not get show when bulletin is not published and user is not author' do
    get bulletin_url(@bulletin)

    assert_response :missing
  end

  test 'should not get show when bulletin is not published' do
    sign_in(@user)
    get bulletin_url(@bulletin)

    assert_response :missing
  end

  test 'should get show for author when bulletin is not published' do
    sign_in(@author)
    get bulletin_url(@bulletin)

    assert_response :success
  end

  test 'should get show for admin when bulletin is not published' do
    sign_in(@admin)
    get bulletin_url(@bulletin)

    assert_response :success
  end

  test 'should not get new, when user is not logged in' do
    get new_bulletin_url

    assert_redirected_to root_url
  end

  test 'should get new, when user is logged in' do
    sign_in(@user)
    get new_bulletin_url

    assert_response :success
  end

  test 'should not create when user is not logged in' do
    assert_no_difference 'Bulletin.count' do
      post bulletins_url, params: { bulletin: @attrs }
    end

    assert_redirected_to root_url
  end

  test 'should create when user is logged in' do
    sign_in(@user)
    post bulletins_url, params: { bulletin: @attrs }

    bulletin = Bulletin.find_by(@attrs.except(:image))

    assert { bulletin }
    assert { bulletin.user == @user }
    assert_redirected_to profile_url
  end

  test 'should not get edit, when user is not logged in' do
    get edit_bulletin_url(@bulletin)

    assert_redirected_to root_url
  end

  test 'should not get edit, when user is not author' do
    sign_in(@user)
    get edit_bulletin_url(@bulletin)

    assert_response :missing
  end

  test 'should not get edit, when admin is not author' do
    sign_in(@admin)
    get edit_bulletin_url(@bulletin)

    assert_response :missing
  end

  test 'should get edit, when user is author' do
    sign_in(@author)
    get edit_bulletin_url(@bulletin)

    assert_response :success
  end

  test 'should not update when user is not logged in' do
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title != @attrs[:title] }
    assert { @bulletin.description != @attrs[:description] }
    assert_redirected_to root_url
  end

  test 'should not update when user not author' do
    sign_in(@user)
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title != @attrs[:title] }
    assert { @bulletin.description != @attrs[:description] }
    assert_response :missing
  end

  test 'should not update when admin not author' do
    sign_in(@admin)
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title != @attrs[:title] }
    assert { @bulletin.description != @attrs[:description] }
    assert_response :missing
  end

  test 'should update bulletin' do
    sign_in(@author)
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title == @attrs[:title] }
    assert { @bulletin.description == @attrs[:description] }
    assert_redirected_to profile_url
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
