class Project < ActiveRecord::Base
  acts_as_context
  acts_as_taggable
  
  def activate
    update_attribute :active, true
  end

  def deactivate
    update_attribute :active, false
  end

  validates_presence_of :title
  validates_uniqueness_of :title
end
