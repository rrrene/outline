class Context < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true

  validates_presence_of :resource
end
