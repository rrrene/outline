
class PagesController < ApplicationController
  content_holder_resources 
  enable_bulk_actions :add_tags, :destroy, :move_to_project, :move_to_new_project

  Project # TODO: fix this lazing loading issue

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

  protected

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
    else
      self.resource = resource_class.new
      # tell inherited_resources something has gone wrong
      resource.errors.add(:base, "new_project is invalid")
      create_with_authorization
    end
  end

  def filter_collection
    if @filter_title = params[:title]
      query = "%#{@filter_title.gsub(' ', '%')}%"
      self.collection = collection.where(["title LIKE ?", query])
    end
  end

  def new_project(attributes)
    project = Project.new(attributes)
    project.user = current_user
    project.domain = current_domain
    project
  end

  def order_by
    "UPPER(title) ASC"
  end

end
