module Outline
  class ContentManager
    class << self
      def register_item_class(model)
        @@item_classes ||= []
        @@item_classes << model unless @@item_classes.include?(model)
      end

      def registered_item_classes
        @@item_classes ||= []
      end
      alias item_classes registered_item_classes
    end
  end
end