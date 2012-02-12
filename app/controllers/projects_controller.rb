class ProjectsController < ApplicationController
  authorized_resources
  enable_bulk_actions :add_tags, :activate, :deactivate, :destroy

  Page

  protected
  
  def filter_collection
    filter_by_title
    if scope = params[:scope].presence
      self.collection = collection.where(:active => true) if scope == 'active'
      self.collection = collection.where(:active => false) if scope == 'inactive'
    end
  end

  def order_by
    "UPPER(title) ASC"
  end
end
