require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index without login" do
    assert_no_login_required_for :index
  end
end
