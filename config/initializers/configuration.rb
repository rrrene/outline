require 'outline'

require 'example'

module Outline
  class Application < Rails::Application
    config.to_prepare do
      # initialization code goes here
      Outline::ContentItems.classes = [Note, TodoList, Link]
    end
  end
end