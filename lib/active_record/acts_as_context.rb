module ActsAsContext
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_context
      instance_eval do
        acts_as_owned_by_user
        has_one :context, :as => :resource, :dependent => :destroy

        after_create :create_context
      end
    end
  end

  def create_context
    Context.create(:resource => self)
  end
end

ActiveRecord::Base.send :include, ActsAsContext