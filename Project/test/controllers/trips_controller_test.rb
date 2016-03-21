require 'test_helper'

class TripsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test "should show the list of trips from one user" do
    t = trips(:myTrip)
    u = users(:margaux)
    get :user_list, id: u.id
    assert_equal assigns(:trips).count, u.trips.count
  end

  test "should index the list of trips" do
    t = trips(:myTrip)
    get :index
    assert_equal assigns(:trips).count, Trip.count
  end

  test "should create trip" do
    sign_in users(:margaux)
    assert_difference('Trip.count') do
      post :create, trip: { title: "My Trip far far away 2", description: "Discover the beauty of freedom" }
    end
  end

  test "should not create a second trip with same title-user" do
    sign_in users(:margaux)
    t = trips(:myTrip)
    post :create, trip: { title: t.title, description: t.description }
    count1 = Trip.count
    assert_response :redirect
    post :create, trip: { title: t.title, description: t.description }
    count2 = Trip.count
    assert_equal count1, count2
  end

  test "should not create trip without member connected" do
    count1 = Trip.count
    post :create, trip: { title: "My Trip far far away", description: "Discover the beauty of freedom" }
    count2 = Trip.count
    assert_equal count1, count2
  end

  test "should edit trip" do
    sign_in users(:margaux)
    t_id = trips(:myTrip).id
    put :update, id: t_id, trip: { title: "My new title", description: "My new description" }
    t2 = trips(:myTrip)
    assert_not_equal Trip.find(t_id).title, t2.title
    assert_not_equal Trip.find(t_id).description, t2.description
  end

  test "should not edit trip without connection and correct member" do
    sign_in users(:steve)
    t_id = trips(:myTrip).id
    put :update, id: t_id, trip: { title: "My new title", description: "My new description" }
    t2 = trips(:myTrip)

    assert_equal Trip.find(t_id).title, t2.title
    assert_equal Trip.find(t_id).description, t2.description
  end

  test "should not edit trip without connection" do
    t_id = trips(:myTrip).id
    put :update, id: t_id, trip: { title: "My new title", description: "My new description" }
    t2 = trips(:myTrip)

    assert_equal Trip.find(t_id).title, t2.title
    assert_equal Trip.find(t_id).description, t2.description
  end

  test "should destroy trip" do
    sign_in users(:margaux)
    t = trips(:myTrip)
    count1 = Trip.count
    delete :destroy, id: t.id
    assert_equal Trip.count, count1-1, "Nombre de voyages #{Trip.count} != #{count1-1}"
  end

  test "should not destroy trip without connection and correct member" do
    t = trips(:myTrip)
    sign_in users(:steve)
    count1 = Trip.count
    delete :destroy, id: t.id
    count2 = Trip.count
    assert_equal count1, count2
  end

  test "should not destroy trip without connection" do
    t = trips(:myTrip)
    count1 = Trip.count
    delete :destroy, id: t.id
    count2 = Trip.count
    assert_equal count1, count2
  end

  test "should show trip" do
    t = trips(:myTrip)
    get :show, id: t.id
    assert_response :success
  end

end
