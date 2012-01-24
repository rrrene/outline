class Content < ActiveRecord::Base
  belongs_to :holder, :polymorphic => true
  has_many :content_items, :dependent => :destroy

  validates_presence_of :holder
end
