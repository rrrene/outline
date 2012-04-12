require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should GET index with login" do
    with_login do |user|
      get :index
      assert_response :redirect
      assert_redirected_to :controller => "activities"
    end
  end

  test "should GET index without login" do
    get :index
    assert_response :redirect
    assert_redirected_to "/login"
  end

  test "should GET index without login or existing users" do
    Domain.destroy_all
    get :index
    assert_response :redirect
    assert_redirected_to "/setup"
  end
end
