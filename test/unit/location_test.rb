require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  test "validates name" do
    location = Location.new
    location.address = locations(:one).address
   
    assert ! location.valid?
    assert location.errors.on(:name)
  end

  test "validates address" do
    location = Location.new
    location.name = "some new name"
    
    assert ! location.valid?
    assert location.errors.on(:address)
  end

end
