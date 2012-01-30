module AuthorizedResources
  PER_PAGE = 30

  module InstanceMethods
    def create_with_authorization(&block)
      create_user_owned_resource
      #block ||= Proc.new do |success, failure|
      #    success.html { redirect_to resource }
      #    failure.html { render :action => "new" }
      #  end
      create!(&block)
    end

    def index
      self.resource = resource_class.new
      filter_collection
      index!
    end

    protected
    
    def begin_of_association_chain
      current_domain
    end

    def collection
      if var = get_collection_ivar
        var
      else
        self.collection = end_of_association_chain.accessible_by(current_ability).order(order_by).paginate(:page => params[:page], :per_page => per_page)
      end
    end

    def collection=(value)
      set_collection_ivar(value)
    end

    def collection_key
      resource_collection_name
    end

    def create_user_owned_resource
      self.resource ||= resource_class.new(params[resource_key])
      resource.user = current_user if resource.respond_to?(:user=)
      resource.domain = current_domain
    end

    def filter_by_title
      if @filter_title = params[:title]
        query = "%#{@filter_title.gsub(' ', '%')}%"
        self.collection = collection.where(["title LIKE ?", query])
      end
    end

    def filter_collection
    end

    def order_by
      "created_at DESC"
    end

    def per_page
      PER_PAGE
    end

    def resource=(value)
      set_resource_ivar(value)
    end

    def resource_key
      resource_instance_name
    end
  end

  module Base
    extend ActiveSupport::Concern
    
    included do
      inherit_resources
      respond_to :html, :js, :json
      before_filter :require_user
      load_and_authorize_resource
      check_authorization
      
      skip_load_and_authorize_resource :only => :index
      skip_authorization_check :only => :index

      self.send :include, InstanceMethods
      alias_method_chain :create, :authorization
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
