class ContentItem < ActiveRecord::Base
  belongs_to :content
  belongs_to :item, :polymorphic => true, :dependent => :destroy

  acts_as_list :scope => :content

  after_save do |content_item|
    if content_item.item.content_id != content_item.content_id
      content_item.item.update_attribute :content_id, content_item.content_id
    end
  end

  validates_presence_of :content
  validates_presence_of :item
end
