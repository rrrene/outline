require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  test "should require login" do
    assert_login_required_for :index
  end
end
