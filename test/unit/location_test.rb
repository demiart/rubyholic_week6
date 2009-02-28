require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "validates name" do
    test_validation_error Location, 'name', "can't be blank"
  end

  test "validates address" do
    test_validation_error Location, 'address', "can't be blank"
  end

end
