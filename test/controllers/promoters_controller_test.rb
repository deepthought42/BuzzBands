require 'test_helper'

class PromotersControllerTest < ActionController::TestCase
  setup do
    @promoter = promoters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promoters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promoter" do
    assert_difference('Promoter.count') do
      post :create, promoter: { string: @promoter.string }
    end

    assert_redirected_to promoter_path(assigns(:promoter))
  end

  test "should show promoter" do
    get :show, id: @promoter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promoter
    assert_response :success
  end

  test "should update promoter" do
    patch :update, id: @promoter, promoter: { string: @promoter.string }
    assert_redirected_to promoter_path(assigns(:promoter))
  end

  test "should destroy promoter" do
    assert_difference('Promoter.count', -1) do
      delete :destroy, id: @promoter
    end

    assert_redirected_to promoters_path
  end
end
