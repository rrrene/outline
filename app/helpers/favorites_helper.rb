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
end
