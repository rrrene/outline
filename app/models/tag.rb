class Tag < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id
  validates_uniqueness_of :title, :scope => :domain_id, :case_sensitive => false
end
