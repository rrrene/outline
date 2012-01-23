require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  setup do
    @project = Project.new
  end

  test "responds to user" do
    assert_not_nil @project
    assert @project.respond_to?(:user), "Project doesnot respond to :user"
  end

  test "creates a context" do
    @project.user = User.first
    @project.domain = Domain.first
    @project.title = "Test"
    assert @project.save
    assert_not_nil @project.context
  end

end
