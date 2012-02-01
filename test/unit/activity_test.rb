require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  setup do
    Thread.current[:activity_user] = User.first
  end

  test "should create activity upon page creation" do
    assert_created(Activity) do
      page = Page.create(:user_id => 1, :domain_id => 1, :title => "A new page")
      assert page.save
    end
  end

  test "should save :rename action if only title attribute is changed" do
    project = Project.last
    project.update_attribute :title, project.title + " (changed)"
    activity = Activity.last
    assert_equal activity.resource, project
    assert_equal "rename", activity.action
  end

  test "should save :rename action if only title attribute is changed although tag list was submitted too" do
    project = Project.last
    project.title = project.title + " (changed)"
    project.tag_list = project.tag_list
    project.save

    activity = Activity.last
    assert_equal activity.resource, project
    assert_equal "rename", activity.action
  end

  test "should save :deactivate action if only active attribute is changed" do
    project = Project.where(:active => true).first
    assert_not_nil project

    project.update_attribute :active, false

    activity = Activity.last
    assert_equal activity.resource, project
    assert_equal "deactivate", activity.action
  end

  test "should save :activate action if only active attribute is changed" do
    project = Project.where(:active => false).first
    assert_not_nil project

    project.update_attribute :active, true

    activity = Activity.last
    assert_equal activity.resource, project
    assert_equal "activate", activity.action
  end
end
