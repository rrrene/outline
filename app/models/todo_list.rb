class TodoList < ActiveRecord::Base
  INACTIVE_TODOS_SHOWN = 3
  acts_as_content_item_group

  def active_todos
    todos.where(:active => true)
  end

  def todos
    ids = inner_content.content_items.map(&:item_id)
    Todo.where(:id => ids)
  end
end
