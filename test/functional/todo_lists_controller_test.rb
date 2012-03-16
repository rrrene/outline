require 'test_helper'

class TodoListsControllerTest < ActionController::TestCase

  test "should require login" do
    assert_login_required_for :index
  end

  test "should GET new" do
    with_login do |user|
      get :new
      assert_not_nil assigns["todo_list"]
      assert_response :success
    end
  end

  test "should POST create" do
    with_login do |user|
      assert_created(TodoList) do
        params = {:todo_list => {:content_id => 1, :title => "New Project"}}
        post :create, params
        assert_response :redirect
      end
    end
  end

  test "should DELETE destroy" do
    with_login do |user|
      assert_destroyed(TodoList) do
        delete :destroy, :id => 1
        assert_response :redirect
      end
    end
  end

  test "should GET edit" do
    with_login do |user|
      get :edit, :id => 1
      assert_not_nil assigns["todo_list"]
      assert_response :success
    end
  end

  test "should PUT update" do
    with_login do |user|
      hash = {:title => "New Title"}
      put :update, :id => 1, :todo_list => hash
      assert_not_nil assigns["todo_list"]
      hash.each do |attribute, value|
        assert_equal value, assigns["todo_list"].send(attribute)
      end
      assert_response :redirect
    end
  end

  test "should GET show" do
    with_login do |user|
      get :show, :id => 1
      assert_not_nil assigns["todo_list"]
      assert_response :success
    end
  end

end
