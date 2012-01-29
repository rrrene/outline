module ActsAsContextItem
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_context_item
      instance_eval do
        acts_as_owned_by_user
        belongs_to :context
        # to be decided: should every item have to have a context?
        #validates_presence_of :context_id
        of_this_kind = self.to_s.underscore.pluralize.to_sym
        ::Context.instance_eval do
          has_many of_this_kind, :dependent => :destroy
        end
        [::Project].each do |model|
          model.instance_eval do
            has_many of_this_kind, :through => :context, :dependent => :destroy
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContextItem