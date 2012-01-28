class ProjectsController < ApplicationController
  authorized_resources
  enable_bulk_actions :add_tags, :activate, :deactivate, :destroy

  protected
  
  def order_by
    "UPPER(title) ASC"
  end
end
