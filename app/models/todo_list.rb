class TodoList < ActiveRecord::Base
  acts_as_content_item_group :for => Todo
end
