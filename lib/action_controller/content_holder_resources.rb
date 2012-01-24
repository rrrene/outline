module ContentHolderResources
  module InstanceMethods
    # ...
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
