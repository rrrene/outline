class TodoListsController < ContentItemsController
  content_item_group_resources

  before_filter :set_body_template, :only => [:index]
    
  Project
  Page

  def set_body_template
    @body_template = :body_yield
  end
end
