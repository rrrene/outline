require 'test_helper'

class SetupControllerTest < ActionController::TestCase
  setup do
    Domain.destroy_all
  end

  test "should get create_first_user" do
    get :create_first_user
    assert_response :success
  end

  test "should create_first_user" do
    assert_equal 0, Domain.count
    assert_equal 0, User.count
    assert_equal 0, Page.count
    assert_equal 0, Project.count
    post :create_first_user, :user => user_params
    assert_response :redirect
    assert_equal 1, Domain.count
    assert_equal 1, User.count
    assert_equal 0, Page.count
    assert_equal 0, Project.count
  end

  test "should create_first_user and example project" do
    post :create_first_user, :user => user_params, :create_example => "true"
    assert_response :redirect
    assert_equal 1, Domain.count
    assert_equal 1, User.count
    assert Page.count > 0
    assert Project.count > 0
  end

  def user_params
    params = {
        :login => "user",
        :email => "someone@outline.dev",
        :password => "asdf",
    }
    params[:password_confirmation] = params[:password]
    params
  end
end
