require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  should_act_as_content_item_resources

  setup do
    @content = TodoList.first.inner_content
    assert_not_nil @content
  end

  def resource_attributes
    {:title => "A new note..."}
  end
end
