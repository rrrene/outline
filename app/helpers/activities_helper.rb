module ActivitiesHelper
  def activity_tt_options(activity)
    options = {
      :model => link_to(activity.resource.class.model_name.human, activity.resource),
      :user => link_to(activity.user.name, activity.user)
    }
  end

  def activity_tt_snippets(activity)
    base = "activities.#{activity.verb}"
    action = activity.action || :default
    [
      "#{base}.#{activity.resource_type.underscore}.#{action}",
      "#{base}.#{action}",
    ]
  end
end
