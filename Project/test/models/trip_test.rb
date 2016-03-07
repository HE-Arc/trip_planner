require 'test_helper'

class TripTest < ActiveSupport::TestCase
  test "invalid without a title" do
    t = trips (:myTrip)
    t.title = nil
    assert !t.valid?, "Title is not being validated"
  end

  test "invalid without a description" do
    t = trips (:myTrip)
    t.description = nil
    assert !t.valid?, "Description is not being validated"
  end

  test "valid with all attributes" do
    t = trips(:myTrip)
    assert t.valid?, "Trip is not valid"
  end

  test "should contain only stage that belong to trip" do
    t = trips(:myTrip)
    assert t.stages.all? {|s| s.trip == t }, "Problem with the relation between Trip and Stages"
  end

  test "should have one user" do
    t = trips(:myTrip)
    assert t.user, "Problem with the relation between User and Trip"
  end

end
