require 'test_helper'

class QuickJumpTargetTest < ActiveSupport::TestCase

  test "should create QuickJumpTarget upon page creation" do
    assert_created(QuickJumpTarget) do
      page = Page.create(:user_id => 1, :domain_id => 1, :title => "A new page")
      assert page.save
    end
  end

  test "should update QuickJumpTarget" do
    project = Project.last
    new_title = project.title + " (changed)"
    project.update_attribute :title, new_title
    
    target = project.quick_jump_target
    assert_equal new_title, project.quick_jump_target.phrase
  end

  test "should update QuickJumpTarget resource on request" do
    resource = QuickJumpTarget.first.resource
    resource.quick_jump_target.destroy
    resource.reload

    chain = QuickJumpTarget.where(:resource_type => resource.class, :resource_id => resource.id)
    assert_equal 0, chain.count
    QuickJumpTarget.update resource
    assert_equal 1, chain.count
  end

  test "should update QuickJumpTarget model on request" do
    QuickJumpTarget.destroy_all
    assert_equal 0, QuickJumpTarget.count
    QuickJumpTarget.update_all Project
    assert QuickJumpTarget.count > 0
  end

end
