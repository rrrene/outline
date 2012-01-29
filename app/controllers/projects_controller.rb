class ProjectsController < ApplicationController
  authorized_resources
  enable_bulk_actions :add_tags, :activate, :deactivate, :destroy

  protected
  
  def filter_collection
    filter_by_title
  end

  def order_by
    "UPPER(title) ASC"
  end
end
