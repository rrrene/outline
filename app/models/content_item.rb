class ContentItem < ActiveRecord::Base
  belongs_to :content
  belongs_to :item, :polymorphic => true

  validates_presence_of :content
  validates_presence_of :item
end
