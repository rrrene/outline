class Todo < ActiveRecord::Base
  acts_as_content_item
  after_create do |todo|
    todo.content_item.move_to_bottom
  end

  validates_presence_of :title
end
