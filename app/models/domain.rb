class Domain < ActiveRecord::Base
  has_many :quick_jump_targets, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :tags, :order => "UPPER(tags.title)"
  has_many :taggings

  def tags_for(association_name)
    type = association_name.to_s.singularize.classify
    tag_ids = taggings.where(:resource_type => type).map(&:tag_id)
    tags.where(:id => tag_ids)
  end
end
