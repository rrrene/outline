module AuthorizedResources
  module InstanceMethods
    def create
      create_user_owned_resource
      create!
    end

    def index
      self.resource = resource_class.new
      index!
    end

    protected
    
    def begin_of_association_chain
      current_domain
    end

    def create_user_owned_resource
      self.resource = resource_class.new(params[resource_class.to_s.underscore])
      resource.user = current_user
      resource.domain = current_domain
    end

    def resource=(value)
      instance_variable_set("@#{resource_class.to_s.underscore}", value)
    end
  end

  module Base
    extend ActiveSupport::Concern
    
    included do
      inherit_resources
      respond_to :html, :js
      load_and_authorize_resource
      check_authorization
      self.send :include, InstanceMethods
    end
  end

  module Config
    extend ActiveSupport::Concern

    module ClassMethods
      def authorized_resources
        self.send :include, Base
      end
    end
  end
end

ActionController::Base.send :include, AuthorizedResources::Config
