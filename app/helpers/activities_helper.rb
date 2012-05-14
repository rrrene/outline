module ActivitiesHelper
  def activity_tt_options(activity)
    options = {
      :model => link_to(activity.resource.class.model_name.human, activity.resource, :class => "resource"),
      :user => link_to(activity.user.name, activity.user, :class => "user")
    }
  end

  def activity_tt_snippets(activity)
    base = "activities.#{activity.verb}"
    action = activity.action || :default
    [
      "#{base}.#{activity.resource_type.underscore}.#{action}",
      "#{base}.#{activity.resource_type.underscore}.default",
      "#{base}.#{action}",
      "#{base}.default",
    ]
  end

  def pages_for_activities(collection)
    content_ids = collection.map { |a| a.content_id }.compact.uniq
    contents = content_ids.map { |content_id| ::Content.find(content_id) if ::Content.exists?(content_id) }.compact
    page_ids = contents.map { |c| c.holder_id if c.holder_type == "Page" }.compact.uniq
    Page.where(:id => page_ids).order("UPPER(title)")
  end

  def projects_for_activities(collection)
    contexts = collection.map { |a| a.context_id }.compact.map { |context_id| ::Context.find(context_id) if ::Context.exists?(context_id) }
    project_ids = contexts.map { |c| c.resource_id if c.resource_type == "Project" }.compact.uniq
    Project.where(:id => project_ids).order("UPPER(title)")
  end
end
