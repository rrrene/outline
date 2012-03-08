class TodoListsController < ContentItemsController
  content_item_group_resources

  Todo

  def index
    index_with_authorization
    @rejected = collection.reject! { |list| list.active_todos.count == 0 }
  end

  def filter_collection
    if params[:project_id]
      self.current_project = Project.find(params[:project_id])
      self.collection = collection.where(:content_id => current_project.content_ids)
    end
    if @filter_title = params[:title]
      q = @filter_title.gsub(/\s+/, "%")
      todos = current_domain.todos.accessible_by(current_ability).where("title LIKE ?", "%#{q}%").group("content_id")
      lists = current_domain.todo_lists.accessible_by(current_ability).where("title LIKE ?", "%#{q}%")
      all_lists = lists + todos.map(&:outer_content).map(&:holder)
      self.collection = collection.where(:id => all_lists.map(&:id))
    end
  end

end
