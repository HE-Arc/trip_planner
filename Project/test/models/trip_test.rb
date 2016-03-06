require 'test_helper'

class TripTest < ActiveSupport::TestCase
  test "invalid without a title" do
    t = trips (:myTrip)
    t.title = nil
    assert !t.valid?, "Title is not being validated"
  end

  test "valid with all attributes" do
    t = trips(:myTrip)
    assert t.valid?, "Trip is not valid"
  end

  test "should contain only stage that belong to trip" do
    t = trips(:myTrip)
    assert t.stages.all? {|s| s.trip == t }
  end

  test "should have one user" do
    t = trips(:myTrip)
    assert t.user
  end

end
