require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  setup do
    @project = Project.new
  end

  test "responds to user" do
    assert_not_nil @project
    assert @project.respond_to?(:user), "Project doesnot respond to :user"
  end

  test "Domain responds to projects" do
    assert Domain.first.respond_to?(:projects), "Domain doesnot respond to :projects"
  end

  test "creates a context" do
    @project.user = User.first
    @project.domain = Domain.first
    @project.title = "Test"
    assert @project.save
    assert_not_nil @project.context
  end

  test "should activate project" do
    project = Project.first
    project.activate
    assert_equal true, project.active?
  end

  test "should deactivate project" do
    project = Project.first
    project.deactivate
    assert_equal false, project.active?
  end

  test "should destroy associated pages" do
    project = Project.first
    assert project.respond_to?(:pages)
    assert_equal false, project.pages.empty?, "project.pages should not be empty"
    assert_destroyed(Page) do
      project.destroy
    end
  end

end
