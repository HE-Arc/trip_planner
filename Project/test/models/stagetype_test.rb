require 'test_helper'

class StagetypeTest < ActiveSupport::TestCase
  test "invalid without a title" do
    stagetype = stagetypes(:randonnee)
    stagetype.title = nil
    assert !stagetype.valid?, "Validation of the title of stagetype doesn't work"
  end

  test "invalid without a icon" do
    stagetype = stagetypes(:randonnee)
    stagetype.icon = nil
    assert !stagetype.valid?, "Validation of the icon of stagetype doesn't work"
  end

  test "valid with all values" do
    stagetype = stagetypes(:randonnee)
    assert stagetype.valid?, 'Stagetype is not valid'
  end

end
