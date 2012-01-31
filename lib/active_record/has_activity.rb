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
    def activity_verb(action, changes)
      # implement me
    end

    def activity_verb=(value)
      @activity_verb = value
    end
  end
end

ActiveRecord::Base.send :include, HasActivity