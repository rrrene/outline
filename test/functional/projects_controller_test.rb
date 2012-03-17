require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  test "should allow bulk actions" do
    record = Project.new
    actions = %w(add_tags activate deactivate destroy)
    assert_equal controller.class.allowed_bulk_actions.sort, actions.sort
    actions.each do |action|
      if controller.respond_to?("bulk_execute_#{action}")
        assert true
      else
        assert record.respond_to?(action), "#{record.class} does not respond_to :#{action} nor is there a :bulk_execute_#{action} method in the controller"
      end
    end
  end

  test "should destroy projects via #bulk_execute" do
    with_login do |user|
      projects = user.domain.projects
      tag_list = %w(one two three)

      assert projects.count > 1, "Not enough projects to test bulk editing"

      params = {
        :bulk => {
          :action => "destroy"
        },
        :projects => projects.map(&:id).map(&:to_s)
      }
      post :bulk_execute, params

      assert_response :redirect
      projects.reload.each do |project|
        assert !Project.exists?(project), "Project should not exists after destroy"
      end
    end
  end

  test "should activate projects via #bulk_execute" do
    with_login do |user|
      projects = user.domain.projects

      assert projects.count > 1, "Not enough projects to test bulk editing"

      params = {
        :bulk => {
          :action => "activate"
        },
        :projects => projects.map(&:id).map(&:to_s)
      }
      post :bulk_execute, params

      assert_response :redirect
      projects.reload.each do |project|
        assert project.active?, "Project should be active"
      end
    end
  end

  test "should deactivate projects via #bulk_execute" do
    with_login do |user|
      projects = user.domain.projects

      assert projects.count > 1, "Not enough projects to test bulk editing"

      params = {
        :bulk => {
          :action => "deactivate"
        },
        :projects => projects.map(&:id).map(&:to_s)
      }
      post :bulk_execute, params

      assert_response :redirect
      projects.reload.each do |project|
        assert !project.active?, "Project not should be active"
      end
    end
  end


  test "should require login" do
    assert_login_required_for :index
  end

  test "should GET new" do
    with_login do |user|
      get :new
      assert_not_nil assigns["project"]
      assert_response :success
    end
  end

  test "should POST create" do
    with_login do |user|
      assert_created(Project) do
        params = {:project => {:title => "New Project"}}
        post :create, params
        assert_response :redirect
      end
    end
  end

  test "should DELETE destroy" do
    with_login do |user|
      assert_destroyed(Project) do
        delete :destroy, :id => 1
        assert_response :redirect
      end
    end
  end

  test "should GET edit" do
    with_login do |user|
      get :edit, :id => 1
      assert_not_nil assigns["project"]
      assert_response :success
    end
  end

  test "should PUT update" do
    with_login do |user|
      hash = {:title => "New Title"}
      put :update, :id => 1, :project => hash
      assert_not_nil assigns["project"]
      hash.each do |attribute, value|
        assert_equal value, assigns["project"].send(attribute)
      end
      assert_response :redirect
    end
  end

  test "should GET show" do
    with_login do |user|
      get :show, :id => 1
      assert_not_nil assigns["project"]
      assert_response :success
    end
  end

  test "should GET index with query" do
    with_login do |user|
      get :index, :query => "test"
      assert_response :success
    end
  end

  test "should GET index with scope: active" do
    with_login do |user|
      get :index, :scope => "active"
      assert_response :success
    end
  end

  test "should GET index with scope: inactive" do
    with_login do |user|
      get :index, :scope => "inactive"
      assert_response :success
    end
  end

end
