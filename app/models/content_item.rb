class ContentItem < ActiveRecord::Base
  belongs_to :content
  belongs_to :item, :polymorphic => true

  acts_as_list :scope => :content

  validates_presence_of :content
  validates_presence_of :item
end
