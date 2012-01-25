module EnableBulkActions
  module InstanceMethods
    def bulk_execute
      action = bulk_action_from_params
      if methods.include?(:"bulk_execute_#{action}")
        m = method(:"bulk_execute_#{action}")
        m.call(bulk_collection_from_params)
      else
        bulk_collection_from_params.each do |record|
          if record.respond_to?(action)
            m = record.method(action)
            args = [action]
            args << params[:bulk][action.to_sym] if m.arity == 1
            record.__send__(*args)
          else
            raise "#{record.class} does not respond_to :#{action}"
          end
        end
      end
      redirect_to(params[:bulk][:return_to] || {:action => 'index'})
    end

    private

    def bulk_action_from_params
      params[:bulk][:action]
    end

    def bulk_collection_from_params
      ids = params[controller_name].map(&:to_i)
      end_of_association_chain.where(:id => ids)
    end

    def validate_bulk_action
      action = bulk_action_from_params
      allowed_actions = self.class.allowed_bulk_actions
      raise bulk_action_error unless allowed_actions.include?(action)
    end

    def bulk_action_error
      "Unknown execute action: #{bulk_action_from_params}\n" << 
      "Valid actions are: #{self.class.allowed_bulk_actions.to_sentence}"
    end
  end

  module Base
    extend ActiveSupport::Concern
    
    included do
      self.send :include, InstanceMethods
      self.send :before_filter, :validate_bulk_action, :only => :bulk_execute
    end

    module ClassMethods
      def allowed_bulk_actions
        @allowed_bulk_actions || []
      end

      def allowed_bulk_actions=(actions)
        @allowed_bulk_actions = actions.map(&:to_s)
      end
    end
  end

  module Config
    extend ActiveSupport::Concern

    module ClassMethods
      def enable_bulk_actions(*actions)
        self.send :include, Base
        self.allowed_bulk_actions = actions
      end
    end
  end
end

ActionController::Base.send :include, EnableBulkActions::Config
