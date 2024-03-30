# frozen_string_literal: true

require 'test_helper'

class Web::Profile::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
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

  test 'should not get new, when user not authorized' do
    get new_bulletin_url

    assert_redirected_to root_url
  end

  test 'should get new, when user authorized' do
    sign_in(@user)
    get new_bulletin_url

    assert_response :success
  end

  test 'should not create when user not authorized' do
    assert_no_difference 'Bulletin.count' do
      post bulletins_url, params: { bulletin: @attrs }
    end

    assert_redirected_to root_url
  end

  test 'should create when user authorized' do
    sign_in(@user)
    post bulletins_url, params: { bulletin: @attrs }

    bulletin = Bulletin.find_by(@attrs.except(:image))

    assert { bulletin }
    assert { bulletin.author == @user }
    assert_redirected_to bulletin_url(bulletin)
  end

  test 'should not get edit, when user not authorized' do
    get edit_bulletin_url(@bulletin)

    assert_redirected_to root_url
  end

  test 'should not update when user not authorized' do
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

  test 'should update bulletin' do
    sign_in(@author)
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title == @attrs[:title] }
    assert { @bulletin.description == @attrs[:description] }
    assert_redirected_to bulletin_url(@bulletin)
  end
end
