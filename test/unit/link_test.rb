require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  setup do
    @link = Link.new
  end

  test "responds to user" do
    assert_not_nil @link
    assert @link.respond_to?(:user), "Link doesnot respond to :user"
  end

  test "should give href with http-protocol if protocol is missing" do
    @link.href = "www.example.org"
    assert_equal "http://www.example.org", @link.href
  end

  test "should give href with given protocol" do
    @link.href = "https://www.example.org"
    assert_equal "https://www.example.org", @link.href
  end

  test "should give href without protocol" do
    @link.href = "http://www.example.org"
    assert_equal "www.example.org", @link.href_without_protocol
  end

end
