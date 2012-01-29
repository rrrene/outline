module ActsAsContentItemGroup
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_content_item_group(options = {})
      instance_eval do
        acts_as_content_item
        acts_as_content_holder
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContentItemGroup

class TodoList < ActiveRecord::Base
  acts_as_content_item_group :for => Todo
end
