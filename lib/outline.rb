module Outline
  class ContentItems
    class << self
      def register_class(model)
        @@item_classes ||= []
        @@item_classes << model unless @@item_classes.include?(model)
      end

      def classes
        @@item_classes ||= []
      end

      def classes=(values)
        @@item_classes = values
      end
    end
  end
end