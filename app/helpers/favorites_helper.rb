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
    current_user.favorites.where(:resource_type => klass).order("created_at DESC").map(&:resource)
  end


  def favorite_project_links
    content_items = ContentItem.where(:content_id => current_project.pages.map(&:inner_content).map(&:id), :item_type => :Link).includes(:item)
    links = content_items.map(&:item)
    links.select { |resource| current_user.favors?(resource) }
  end

end
