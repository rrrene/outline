class TodoList < ActiveRecord::Base
  INACTIVE_TODOS_SHOWN = 3
  acts_as_content_item_group :for => Todo
end
