class TodoListsController < ContentItemsController
  content_item_group_resources

  Todo

  def index
    index_with_authorization
    @rejected = collection.reject! { |list| list.active_todos.count == 0 }
  end

  def collection_for_query(query)
    collection.where(:id => all_lists_for_query(query).map(&:id))
  end

  def all_lists_for_query(query)
    todos = current_domain.todos.accessible_by(current_ability).where("title LIKE ?", query).group("content_id")
    todos_lists = todos.map(&:outer_content).map(&:holder)
    lists = current_domain.todo_lists.accessible_by(current_ability).where("title LIKE ?", query)
    lists + todos_lists
  end

end
