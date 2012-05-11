class Tagging < ActiveRecord::Base
  belongs_to :domain
  belongs_to :tag
  belongs_to :resource, :polymorphic => true

  validates_presence_of :domain_id
  validates_presence_of :tag_id
  validates_presence_of :resource
end
