module TodoListsHelper
  def todo_content_items(todo_list, active, limit = nil)
    content_id = todo_list.inner_content.id
    arel = Todo.where(:content_id => content_id, :active => active)
    arel = arel.limit(limit) if limit.present?
    arel.includes(:content_item).order("content_items.position").map(&:content_item)
  end

  def todo_content_items_count(todo_list, active, limit = nil)
    content_id = todo_list.inner_content.id
    Todo.where(:content_id => content_id, :active => active).count
  end

  def inactive_todos_to_show
    %w(todo_lists todos).include?(controller_name) ? 1_000_000 : TodoList::INACTIVE_TODOS_SHOWN
  end
end
