module FavoritesHelper

  def data_attributes_for_favorite_toggle(item)
    {
        :"data-toggle" => "favorite",
        :"data-resource-type" => item.class.to_s,
        :"data-resource-id" => item.id,
        :"data-initial-value" => current_user.favors?(item),
        :"data-title-active" => favor_title(item, true),
        :"data-title-inactive" => favor_title(item, false),
    }
  end

  def favor_title(item, favored = true)
    base = item.class.to_s.underscore.pluralize
    tt("#{base}.options.unfavor", "content_items.options.#{favored ? :unfavor : :favor}")
  end

  def favor_icon_with_title(resource)
    icon(favorited?(resource) ? "no-favorite" : "favorite") + favor_title(resource, favorited?(resource))
  end

  def favorite_button(resource)
    render :partial => "favorites/button", :locals => {:resource => resource}
  end

  def favorite_pages
    @favorite_pages ||= favorite_resources(Page).sort_by { |p| p.title.upcase }
  end

  def favorite_projects
    @favorite_projects ||= favorite_resources(Project).sort_by { |p| p.title.upcase }
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
