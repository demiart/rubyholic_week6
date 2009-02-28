require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test  "name and only name must exist" do
    bad_group = Group.new
    bad_group.save
    assert(bad_group.errors.on('name').to_a.include?("can't be blank"))
  end

end
