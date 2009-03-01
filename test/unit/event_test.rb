require 'test_helper'

class EventTest < ActiveSupport::TestCase
   test "validates name must exist" do
    test_validation_error Event, 'name', "can't be blank"
  end

  test "validates startime must exist" do
    test_validation_error Event, 'start_time', "can't be blank"
  end

end
