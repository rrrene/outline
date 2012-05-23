class Context < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true

  def self.association_for(resource)
    if resource.respond_to?(:context)
      resource.context
    elsif content = Content.association_for(resource).presence
      association_for(content.holder)
    end
  end

  validates_presence_of :resource
end
