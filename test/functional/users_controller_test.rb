require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should require login" do
    assert_login_required_for :index
  end

  test "should GET new" do
    with_login do |user|
      get :new
      assert_not_nil assigns["user"]
      assert_response :success
    end
  end

  test "should POST create" do
    with_login do |user|
      assert_created(User) do
        params = {:user => {:login => "good_user", :email => "good@user.com", :password => "asdf", :password_confirmation => "asdf"}}
        post :create, params
        assert_response :redirect
      end
    end
  end

  test "should DELETE destroy" do
    with_login do |user|
      assert_destroyed(User) do
        delete :destroy, :id => 1
        assert_response :redirect
      end
    end
  end

  test "should GET edit" do
    with_login do |user|
      get :edit, :id => 1
      assert_not_nil assigns["user"]
      assert_response :success
    end
  end

  test "should PUT update" do
    with_login do |user|
      hash = {:login => "better_user"}
      put :update, :id => 1, :user => hash
      assert_not_nil assigns["user"]
      hash.each do |attribute, value|
        assert_equal value, assigns["user"].send(attribute)
      end
      assert_response :redirect
    end
  end

  test "should GET show" do
    with_login do |user|
      get :show, :id => 1
      assert_not_nil assigns["user"]
      assert_response :success
    end
  end
end
