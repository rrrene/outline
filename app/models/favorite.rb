class Favorite < ActiveRecord::Base
  belongs_to :domain
  belongs_to :user
  belongs_to :resource, :polymorphic => true

  validates_presence_of :domain
  validates_presence_of :user
  validates_presence_of :resource
end
