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

end
