require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, :location => { :address => "1st street", :name => "new loc" }
    end

    assert_redirected_to :controller => :events, :action => :new
  end

  test "should auto geocode lat long" do
    post :create, :location => { :name => "demi home", :address => "13919 20th pl. w., Lynnwood, WA 98087"}
    loc = Location.last
    assert_equal 'demi home', loc.name
    assert_equal 47.8716, loc.latitude
    assert_equal -122.26, loc.longitute
  end

  test "should show location" do
    get :show, :id => locations(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => locations(:one).id
    assert_response :success
  end

  test "should update location" do
    put :update, :id => locations(:one).id, :location => { }
    assert_redirected_to location_path(assigns(:location))
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, :id => locations(:one).id
    end

    assert_redirected_to locations_path
  end

  test "cant choose without a group" do
    get :choose
    assert_redirected_to groups_path
  end

  test "can choose with a group" do
    get :choose, :group => groups(:one).id
    assert_response :success
  end
end
