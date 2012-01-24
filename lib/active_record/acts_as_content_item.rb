module ActsAsContentItem
  extend ActiveSupport::Concern
 
  module ClassMethods
    def acts_as_content_item
      instance_eval do
        acts_as_owned_by_user
        belongs_to :content
        has_one :content_item, :as => :item, :dependent => :destroy

        after_create do |item|
          content_item = ContentItem.create!(:item => item, :content => item.content)
          content_item.move_to_top
        end

        validates_presence_of :content
      end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContentItem