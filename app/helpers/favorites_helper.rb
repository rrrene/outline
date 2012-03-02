module FavoritesHelper

  def favorite_button(resource)
    render :partial => "favorites/button", :locals => {:resource => resource}
  end

  def favorite_pages
    @favorite_pages ||= favorite_resources Page
  end

  def favorite_projects
    @favorite_projects ||= favorite_resources Project
  end

  def favorite_todo_lists
    @favorite_todo_lists ||= favorite_resources TodoList
  end

  def favorite_resources(klass)
    current_user.favorites.where(:resource_type => klass).order("updated_at DESC").map(&:resource)
  end


  def favorite_project_todo_lists
    favorite_project_todo_lists ||= favorite_project_resources TodoList
  end

  def favorite_project_links
    @favorite_project_links ||= favorite_project_resources Link
  end

  def favorite_project_resources(klass)
    content_items = ContentItem.where(:content_id => current_project.content_ids, :item_type => klass.to_s).includes(:item).order("updated_at DESC")
    content_items.map(&:item).select { |resource| current_user.favors?(resource) }
  end
end
