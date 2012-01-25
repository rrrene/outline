Project
class PagesController < ApplicationController
  content_holder_resources 
  enable_bulk_actions :destroy, :move_to_project, :move_to_new_project

  def bulk_execute_move_to_new_project(collection)
    @project = Project.new(params[:bulk][:new_project])
    @project.user = current_user
    @project.domain = current_domain
    if @project.valid?
      @project.save
      collection.each do |record|
        record.move_to_project @project
      end
    end
  end
end
