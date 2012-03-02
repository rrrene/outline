class Project < ActiveRecord::Base
  acts_as_content_holder
  acts_as_context
  acts_as_taggable_by_user
  has_quick_jump_target { title }
  
  def activate
    update_attribute :active, true
  end

  def deactivate
    update_attribute :active, false
  end

  # TODO: remove hardcoded :pages association. maybe move content_ids method to Context
  def content_ids
    @content_ids ||= pages.map(&:inner_content).map(&:id) + [inner_content.id]
  end

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :domain_id
end
