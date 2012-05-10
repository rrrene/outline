class Activity < ActiveRecord::Base
  belongs_to :domain
  belongs_to :user
  belongs_to :context
  belongs_to :content
  belongs_to :resource, :polymorphic => true

  class << self
    def record(resource, verb)
      no_activity_recorded = !resource.respond_to?(:activity_recorded) || !resource.activity_recorded
      if current_user.present? && no_activity_recorded
        attributes = {
          :resource => resource, 
          :user => current_user, 
          :domain => current_user.domain, 
          :action => action_for(resource, verb),
          :verb => verb.to_s
        }
        attributes[:context_id] = context_for(resource).try(:id)
        attributes[:content_id] = content_for(resource).try(:id)
        Activity.create(attributes)
        resource.activity_recorded = true if resource.respond_to?(:activity_recorded=)
      end
    end

    def action_for(resource, verb)
      action = resource.instance_variable_get("@activity_action")
      if action.blank? && resource.respond_to?(:activity_action)
        changes = resource.changes
        changes.delete(:updated_at)
        action = resource.activity_action(verb, changes)
      end
      action
    end

    def context_for(resource)
      if resource.respond_to?(:context)
        resource.context
      elsif content = content_for(resource).presence
        context_for(content.holder)
      end
    end

    def content_for(resource)
      if resource.respond_to?(:content)
        resource.content
      elsif resource.respond_to?(:outer_content)
        resource.outer_content
      elsif resource.respond_to?(:inner_content)
        resource.inner_content
      end
    end

    def current_user
      Thread.current[:activity_user]
    end
  end
end
