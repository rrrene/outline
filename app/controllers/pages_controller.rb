Project
 Note
 Link
class PagesController < ApplicationController
  content_holder_resources 
  enable_bulk_actions :add_tags, :destroy, :move_to_project, :move_to_new_project

  def create
    if add_to_new_project? 
      create_with_new_project
    else
      create_with_authorization
    end
  end

  def bulk_execute_move_to_new_project(collection)
    @new_project = new_project(params[:bulk][:new_project])
    if @new_project.valid?
      @new_project.save
      collection.each do |record|
        record.move_to_project @new_project
      end
    end
  end

  private

  def add_to_new_project?
    params[:page][:context_id].to_i == -1
  end

  def create_with_new_project
    @new_project = new_project(params[:project])
    if @new_project.valid?
      create_with_authorization
      if resource.valid?
        @new_project.save
        resource.move_to_project(@new_project)
      end
    end
  end

  def new_project(attributes)
    project = Project.new(attributes)
    project.user = current_user
    project.domain = current_domain
    project
  end

end
