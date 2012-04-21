require 'outline/setup'
require 'outline/create_example_resources'

module Outline
  THEMES = Dir[File.join(Rails.root, 'app', 'assets', 'stylesheets', 'themes', '**', 'all.css*')].map { |f| f.scan(/\/(\w+)\/all.css/) }.flatten

  module ClassesConfig
    def register_class(model)
      @classes ||= []
      @classes << model unless @classes.include?(model)
    end

    def classes
      @classes ||= []
    end

    def classes=(values)
      @classes = values
    end
  end

  class Contexts
    class << self
      include ClassesConfig
    end
  end
  class ContextItems
    class << self
      include ClassesConfig
    end
  end
  class ContentItems
    class << self
      include ClassesConfig

      def postable_directly
        classes - not_postable_directly
      end

      def not_postable_directly(model = nil)
        @not_postable_directly ||= []
        @not_postable_directly << model if model && !@not_postable_directly.include?(model)
        @not_postable_directly
      end
    end
  end
end