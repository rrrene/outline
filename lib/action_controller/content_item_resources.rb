module ContentItemResources
  module InstanceMethods
    def create_with_redirect_to_holder
      create_with_authorization do |success, failure|
        success.html { redirect_to resource.content.holder }
      end
    end

    def render_action_with_fallback
      if template_exists?("#{controller_name}/#{action_name}")
        method("#{action_name}_without_fallback").call
      else
        render :file => "content_items/#{action_name}"
      end
    end
  end

  module Base
    extend ActiveSupport::Concern
    include AuthorizedResources::Base

    included do
      self.send :include, InstanceMethods
      alias_method_chain :create, :redirect_to_holder
      
      [:new, :edit, :show].each do |action|
        define_method "#{action}_with_fallback" do
          render_action_with_fallback
        end
        alias_method_chain action, :fallback
      end
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
