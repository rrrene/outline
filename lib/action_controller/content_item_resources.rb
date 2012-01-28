module ContentItemResources
  module InstanceMethods
    def create_with_redirect_to_holder
      create_with_authorization do |success, failure|
        success.html { redirect_to resource.content.holder }
      end
    end

    def render_with_template_fallback
      method("#{action_name}_without_fallback").call
      unless performed?
        unless template_exists?("#{controller_name}/#{action_name}")
          fallback = "content_items/#{action_name}"
          if template_exists?(fallback)
            render :file => fallback 
          else
            nil
          end
        end
      end
    end
  end

  module Base
    extend ActiveSupport::Concern
    include AuthorizedResources::Base

    included do
      self.send :include, InstanceMethods
      alias_method_chain :create, :redirect_to_holder
      
      [:new, :create, :edit, :destroy, :update, :show].each do |action|
        define_method "#{action}_with_fallback" do
          render_with_template_fallback
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
