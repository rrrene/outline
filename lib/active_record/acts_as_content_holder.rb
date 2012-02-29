module ActsAsContentHolder
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_content_holder
      instance_eval do
        acts_as_owned_by_user
        has_one :inner_content, :class_name => "Content", :as => :holder, :dependent => :destroy
        has_many :content_items, :through => :content, :order => 'position'

        after_create do |holder|
          holder.create_inner_content
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContentHolder