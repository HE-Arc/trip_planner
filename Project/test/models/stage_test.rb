require 'test_helper'

class StageTest < ActiveSupport::TestCase

  test "invalid without a title" do
    stage = stages(:petite_promenade)
    stage.title = nil
    assert !stage.valid?, "Validation of the stage doesn't work"
  end

  test "valid with all values" do
    stage = stages(:petite_promenade)
    assert stage.valid?, 'Stage is not valid'
  end

  test "should have stagetype" do
    stage = stages(:petite_promenade)
    assert !stage.stagetype.nil?, 'Missing stagetype'
  end

  test "should belongs to one trip" do
    stage = stages(:petite_promenade)
    assert !stage.trip.nil?, "Stage hasn't a trip"
  end

end
