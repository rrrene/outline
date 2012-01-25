class Page < ActiveRecord::Base
  acts_as_context_item
  acts_as_content_holder

  def move_to_project(project_id)
    if project = Project.find(project_id)
      self.context = project.context
      self.save!
    end
  end

  validates_presence_of :title
  validates_uniqueness_of :title
end
