require 'test_helper'

class GearListsControllerTest < ActionController::TestCase
  setup do
    @gear_list = gear_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gear_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gear_list" do
    assert_difference('GearList.count') do
      post :create, gear_list: { intro: @gear_list.intro, name: @gear_list.name, trip_id: @gear_list.trip_id }
    end

    assert_redirected_to gear_list_path(assigns(:gear_list))
  end

  test "should show gear_list" do
    get :show, id: @gear_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gear_list
    assert_response :success
  end

  test "should update gear_list" do
    put :update, id: @gear_list, gear_list: { intro: @gear_list.intro, name: @gear_list.name, trip_id: @gear_list.trip_id }
    assert_redirected_to gear_list_path(assigns(:gear_list))
  end

  test "should destroy gear_list" do
    assert_difference('GearList.count', -1) do
      delete :destroy, id: @gear_list
    end

    assert_redirected_to gear_lists_path
  end
end
