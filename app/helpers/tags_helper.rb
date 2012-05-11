module TagsHelper

  def link_tag(tag, active = false)
    render "tags/tag", :tag => tag, :active => active
  end

  def render_tags_for(resource)
    render("tags/tags", :tags => resource.tags) if resource.respond_to?(:tags)
  end

end
