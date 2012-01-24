module ActsAsContentHolder
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_content_holder
      instance_eval do
        acts_as_owned_by_user
        has_one :content, :as => :holder, :dependent => :destroy
        has_many :content_items, :through => :content

        after_create do |holder|
          Content.create(:holder => holder)
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContentHolder