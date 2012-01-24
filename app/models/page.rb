class Page < ActiveRecord::Base
  acts_as_context_item
  acts_as_content_holder

  validates_presence_of :title
  validates_uniqueness_of :title
end
