class Project < ActiveRecord::Base
  acts_as_context
  
  validates_presence_of :title
  validates_uniqueness_of :title
end
