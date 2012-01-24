module ContentItemResources
  module InstanceMethods
    def create
      create_user_owned_resource
      create! do |format|
        if resource.save
          format.html { redirect_to resource.content.holder }
        else
          raise resource.errors.full_messages.inspect
        end
      end
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
      def content_item_resources
        self.send :include, Base
      end
    end
  end
end

ActionController::Base.send :include, ContentItemResources::Config
