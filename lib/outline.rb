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
    end
  end
end