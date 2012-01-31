class ActivitiesController < ApplicationController
  authorized_resources

  def index
    @activity = Activity.new
    @activities = current_domain.activities.where(["verb NOT IN (?)", %w(read delete)]).order("created_at DESC").limit(20)
    @recently_viewed = current_domain.activities.where(:verb => :read, :resource_type => %w(Project Page)).group("resource_type, resource_id").limit(20).map(&:resource)
  end
end
