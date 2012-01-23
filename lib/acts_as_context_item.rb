module ActsAsContextItem
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_context_item
      instance_eval do
        acts_as_owned_by_user
        belongs_to :context
        # to be decided: should every item have to have a context?
        #validates_presence_of :context_id
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContextItem