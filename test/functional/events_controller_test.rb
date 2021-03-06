require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "cant get new without group" do
    get :new
    assert_redirected_to :controller => 'groups', :action => 'index'
    assert_match /must be created attached to a group/i, flash[:notice]
  end

  test "getting new with a group id results in redirect to location/choose" do
    get :new, :event => { :group_id => groups(:one).id }
    assert_redirected_to :controller => 'locations', :action => 'choose'
  end

  test "getting new with a group id and location id results in succes" do
    get :new, :event => { :group_id => groups(:one).id,
      :location_id => locations(:one).id }
    assert_response :success
  end


  test "create event redirects on success" do
    assert_difference('Event.count') do
      post :create, :event => { :group_id => groups(:one).id,
        :location_id => locations(:one).id,
        :name => "event name",
        :start_time => "2009-03-10 19:00:00" }
    end

    assert_redirected_to groups(:one)
  end

  test "should show event" do
    get :show, :id => events(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => events(:one).id
    assert_response :success
  end

  test "should update event" do
    put :update, :id => events(:one).id, :event => { }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event and redirect to event group page" do
    eid = events(:one).id
    group = events(:one).group

    assert_difference('Event.count', -1) do
      delete :destroy, :id => eid
    end

    assert_redirected_to group
  end
end
