module HasActivity
  extend ActiveSupport::Concern
 
  module ClassMethods
    def has_activity
      instance_eval do
        attr_accessor :activity_recorded
        self.send :include, ActivityMethods
        has_many :activities, :as => :resource #, :dependent => :destroy # NOTE: if we set dependent to :destroy, then destroy makes no sense as an action
        after_create { |item| Activity.record(item, :create) }
        after_save { |item| Activity.record(item, :update) }
        after_destroy { |item| Activity.record(item, :delete) }
      end
    end
  end

  module ActivityMethods
    def activity_action(verb, changes)
      basic_activity_action_for(verb, changes)
    end

    def activity_action=(value)
      @activity_action = value
    end

    def basic_activity_action_for(verb, changes)
      if verb == :update && changes.size == 1
        activity_action_for_single_attribute_update(changes)
      end
    end

    def activity_action_for_single_attribute_update(changes)
      if changes[:title]
        "rename"
      elsif change = changes[:active]
        change.last == true ? "activate" : "deactivate"
      elsif change = changes[:context_id]
        "move_to_context"
      elsif change = changes[:content_id]
        "move_to_content"
      end
    end
  end
end

ActiveRecord::Base.send :include, HasActivity