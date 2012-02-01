class TodosController < ContentItemsController
  content_item_resources

  def set_active
  	resource.update_attribute :active, params[:active] == "true"
  end
end
