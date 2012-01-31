module HasQuickJumpTarget
  extend ActiveSupport::Concern
 
  module ClassMethods
    def has_quick_jump_target(&block)
      if block_given?
        instance_eval do
          has_one :quick_jump_target, :as => :resource, :dependent => :destroy
          after_save { |item| QuickJumpTarget.update(item) }
          define_method(:quick_jump_phrase, &block)
        end
      else
        raise "No block provided for :has_quick_jump_target"
      end
    end
  end
end

ActiveRecord::Base.send :include, HasQuickJumpTarget