class ActivitiesController < ApplicationController
  ACTIVITIES_PER_PAGE = 20
  authorized_resources

  def index
    @activity = Activity.new
    @activities = current_domain.activities.where(["verb NOT IN (?)", %w(read delete)])
                                            .group("resource_type, resource_id")
                                            .order("id DESC")
                                            .limit(ACTIVITIES_PER_PAGE)
    @activities = @activities.map do |activity| 
      Activity.where(:resource_type => activity.resource_type, :resource_id => activity.resource_id)
              .where(["verb NOT IN (?)", %w(read delete)])
              .order("id DESC")
              .first
    end
    @activities.sort_by!(&:id).reverse!

  end
end
