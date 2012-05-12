module TagsHelper

  def link_tag(tag, options = {})
    resource = options[:resource]
    active = current_tag == tag
    classes = ["tag"]
    classes << "tag-#{tag.style}" if tag.style
    classes << "tag-with-remove" if resource.present?
    render "tags/tag", :tag => tag, :tag_resource => resource, :active => active, :classes => classes
  end

  def render_tags_for(resource)
    render("tags/tags", :tags => resource.tags, :resource => resource) if resource.respond_to?(:tags)
  end

  def current_tag
    if tag_id = @filter_tag.presence
      @current_tag ||= current_domain.tags.find(tag_id)
    end
  end

end
