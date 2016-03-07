require 'test_helper'

class TripsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test "should get index" do
    t = trips(:myTrip)
    get :index
    assert_response :success
    assert_not_nil assigns(:trips)
  end

  test "should create trip" do
    u = users(:margaux)
    assert_difference('Trip.count') do
      post :create, title: "My Trip far far away", description: "Discover the beauty of freedom", user_id: u.id
    end
  end

  test "should destroy trip" do
    t = trips(:myTrip)
    assert_difference('Trip.count') do
      delete :destroy, id: t.id
    end
  end

  test "should not destroy trip without connection and correct member" do
    u1 = users(:margaux)
    u2 = users(:steve)
    t = trips(:myTrip)
    current_user = u2
    count1 = Trip.count
    delete :destroy, id: t.id
    count2 = Trip.count
    assert_same count1, count2
  end

  test "should not destroy trip without connection" do
    t = trips(:myTrip)
    current_user = nil
    count1 = Trip.count
    delete :destroy, id: t.id
    count2 = Trip.count
    assert_same count1, count2
  end

  test "should show trip" do
    t = trips(:myTrip)
    get :show, id: t.id
    assert_response :success
  end

end
