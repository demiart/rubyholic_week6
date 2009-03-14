require 'test_helper'

class GroupsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should persist location choice across calls in select dd" do
    loc = locations(:two)
    get :index, :params => { 'location' => loc.id }
    assert_select "option", :selected => 'selected', :text => loc.name
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, :group => { :name => "something" }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, :id => groups(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => groups(:one).id
    assert_response :success
  end

  test "should update group" do
    put :update, :id => groups(:one).id, :group => { }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, :id => groups(:one).id
    end

    assert_redirected_to groups_path
  end
end
