module ContentHolderResources
  module InstanceMethods
    def sort_content
      content = resource.inner_content
      order = params[:content_item]
      order.map!(&:to_i)
      content_items = ContentItem.where(:id => order)
      content_items.each do |content_item|
        content_item.content = content
        content_item.position = order.index(content_item.id) + 1 
        content_item.save
      end
      render :text => ""
    end
  end

  module Base
    extend ActiveSupport::Concern
    include AuthorizedResources::Base

    included do
      self.send :include, InstanceMethods
    end
  end

  module Config
    extend ActiveSupport::Concern

    module ClassMethods
      def content_holder_resources
        self.send :include, Base
      end
    end
  end
end

ActionController::Base.send :include, ContentHolderResources::Config
