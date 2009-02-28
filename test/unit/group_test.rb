require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "validates name" do
    test_validation_error Group, 'name', "can't be blank"
  end


  def assert_url is_valid, group, url
    group.website_url = url
    group.save
    errors = group.errors.on('website_url')
    if(is_valid)
      assert_nil(errors)
    else
      assert(errors)
    end
  end

  test "website url can be blank" do
    g = Group.new
    assert_url true, g, ""
  end

  test "bad urls are bad" do
    g = Group.new
    assert_url false, g, 'a'
    assert_url false, g, 'http:/bad.url.com'
    assert_url false, g, 'http://bad'
    assert_url false, g, 'http:/bad.url.com'
    assert_url false, g, 'ftp://bad.url.com'
    assert_url false, g, 'http://bad..com'
  end

  test "good urls are good"  do
    g = Group.new
    assert_url true, g, 'https://good.url.com'
    assert_url true, g, 'http://yay.url.biz'
    assert_url true, g, 'http://uwruby.com'
    assert_url true, g, 'http://www.u123.com/'
    assert_url true, g, 'http://bad.goawayforever.com/this/should/work.html'
    assert_url true, g, 'https://happy.laughter.me'
  end

end
