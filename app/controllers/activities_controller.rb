class ActivitiesController < ApplicationController
  authorized_resources

  def index
    @activity = Activity.new
    @activities = current_domain.activities.where(["verb NOT IN (?)", %w(read delete)])
  end
end
