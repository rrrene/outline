class Content < ActiveRecord::Base
  belongs_to :holder, :polymorphic => true
  has_many :content_items, :order => 'position', :dependent => :destroy

  def content_item_ids=(ids)
    ids.map!(&:to_i)
    content_items = ContentItem.where(:id => ids)
    content_items.each do |content_item|
      content_item.content = self
      content_item.position = ids.index(content_item.id) + 1 
      content_item.save
    end
  end

  def self.association_for(resource)
    if resource.respond_to?(:content)
      resource.content
    elsif resource.respond_to?(:outer_content)
      resource.outer_content
    elsif resource.respond_to?(:inner_content)
      resource.inner_content
    end
  end

  validates_presence_of :holder
end
