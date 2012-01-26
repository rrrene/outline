module ContentItemResources
  module InstanceMethods
    def create_with_redirect_to_holder
      create_with_authorization do |success, failure|
        success.html { redirect_to resource.content.holder }
      end
    end
  end

  module Base
    extend ActiveSupport::Concern
    include AuthorizedResources::Base

    included do
      self.send :include, InstanceMethods
      alias_method_chain :create, :redirect_to_holder
    end
  end

  module Config
    extend ActiveSupport::Concern

    module ClassMethods
      def content_item_resources
        self.send :include, Base
      end
    end
  end
end

ActionController::Base.send :include, ContentItemResources::Config
