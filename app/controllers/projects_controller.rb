class ProjectsController < ApplicationController
  authorized_resources
  enable_bulk_actions :activate, :deactivate, :destroy
end
