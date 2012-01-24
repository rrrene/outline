class Content < ActiveRecord::Base
  belongs_to :holder, :polymorphic => true
  has_many :content_items, :order => 'position', :dependent => :destroy

  validates_presence_of :holder
end
