module FavoritesHelper
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
    current_user.favorites.where(:resource_type => klass).map(&:resource)
  end
end
