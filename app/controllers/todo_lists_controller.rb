class TodoListsController < ContentItemsController
  content_item_group_resources

  def index
    index_with_authorization
    @rejected = collection.reject! { |list| list.active_todos.count == 0 }
  end
end
