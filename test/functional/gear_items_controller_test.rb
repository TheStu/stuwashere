require 'test_helper'

class GearItemsControllerTest < ActionController::TestCase
  setup do
    @gear_item = gear_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gear_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gear_item" do
    assert_difference('GearItem.count') do
      post :create, gear_item: { gear_list_id: @gear_item.gear_list_id, group_type: @gear_item.group_type, name: @gear_item.name, post_id: @gear_item.post_id, weight: @gear_item.weight }
    end

    assert_redirected_to gear_item_path(assigns(:gear_item))
  end

  test "should show gear_item" do
    get :show, id: @gear_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gear_item
    assert_response :success
  end

  test "should update gear_item" do
    put :update, id: @gear_item, gear_item: { gear_list_id: @gear_item.gear_list_id, group_type: @gear_item.group_type, name: @gear_item.name, post_id: @gear_item.post_id, weight: @gear_item.weight }
    assert_redirected_to gear_item_path(assigns(:gear_item))
  end

  test "should destroy gear_item" do
    assert_difference('GearItem.count', -1) do
      delete :destroy, id: @gear_item
    end

    assert_redirected_to gear_items_path
  end
end
