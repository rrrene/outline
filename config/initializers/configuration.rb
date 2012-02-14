require 'outline'

require 'example'

module Outline
  class Application < Rails::Application
    config.to_prepare do
      # initialization code goes here
      Outline::Contexts.classes = [Project]
      Outline::ContextItems.classes = [Page]
      Outline::ContentItems.classes = [Note, TodoList, Link]
    end
  end
end