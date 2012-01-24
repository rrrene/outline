class Note < ActiveRecord::Base
  acts_as_content_item
  
  validates_presence_of :text
end
