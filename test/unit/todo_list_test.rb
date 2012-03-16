require 'test_helper'

class TodoListTest < ActiveSupport::TestCase
  test "should create todo list on page" do
    page = Page.first
    page_content = page.inner_content
    assert_not_nil page_content
    page_content_id = page_content.id

    todo_list = TodoList.new(:title => "Todo List")
    todo_list.content_id = page_content_id
    todo_list.user = page.user
    todo_list.domain = page.domain
    assert_not_nil todo_list.outer_content, "todo_list should belong to page's content object"
    assert_nil todo_list.inner_content, "todo_list should not have an own content object"

    assert todo_list.valid?, "todo_list should be valid"

    todo_list.save

    assert_not_nil todo_list.outer_content, "todo_list should belong to page's content object"
    assert_not_nil todo_list.inner_content, "todo_list should have created an own content object"

    assert_not_equal todo_list.inner_content, todo_list.outer_content, "inner and outer_content should not be equal"
    assert_not_equal page_content_id, todo_list.inner_content.id

    assert_equal page_content_id, todo_list.outer_content.id
  end

  test "should give todos and active_todos" do
    todo_list = TodoList.first
    assert_not_nil todo_list.todos
    assert_not_nil todo_list.active_todos
  end
end
