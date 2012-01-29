module ContentItemGroupResources
  module InstanceMethods
    def create
      create_without_redirect_to_holder
    end
  end

  module Base
    extend ActiveSupport::Concern

    included do
      content_holder_resources
      content_item_resources
      self.send :include, InstanceMethods
    end
  end

  module Config
    extend ActiveSupport::Concern

    module ClassMethods
      def content_item_group_resources
        self.send :include, Base
      end
    end
  end
end

ActionController::Base.send :include, ContentItemGroupResources::Config
