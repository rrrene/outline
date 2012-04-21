class ActivitiesController < ApplicationController
  ACTIVITIES_PER_PAGE = 20
  authorized_resources

  def index
    @start_time = params[:start_time].presence.try(:to_i) || activity_chain.first.created_at.midnight.to_i
    @end_time = @start_time + 1.day.to_i
    @activity = Activity.new
    @activities = activities_between(@start_time, @end_time)
    if prev_activity = activity_chain.where("created_at < ?", Time.at(@start_time)).first
      @prev_time = prev_activity.created_at.midnight.to_i
    end
    if next_activity = activity_chain.where("created_at >= ?", Time.at(@end_time)).first
      @next_time = next_activity.created_at.midnight.to_i
    end
  end

  def activity_chain
    current_domain.activities.where(["verb NOT IN (?)", %w(read delete)])
    .order("id DESC")
  end

  def activities_between(start_time, end_time)
    activities = activity_chain.group("resource_type, resource_id").where("created_at >= ? AND created_at < ?", Time.at(start_time), Time.at(end_time))
    activities = activities.map do |activity|
      activity_chain.where(:resource_type => activity.resource_type, :resource_id => activity.resource_id)
      .where("created_at >= ? AND created_at < ?", Time.at(start_time), Time.at(end_time))
      .first
    end
    activities.sort_by(&:id).reverse
  end
end
