class QuickJumpTargetsController < ApplicationController
  before_filter :require_user

  def index
    render_targets
  end

  def pages
    render_targets("Page")
  end

  private

  def render_targets(types = nil)
    phrase = params[:query].to_s
    phrase = phrase.split(/\s+/).join('%')
    phrase = "%#{phrase}%"
    collection = current_domain.quick_jump_targets.where(["phrase LIKE ?", phrase])
    collection = collection.where(:resource_type => [types].flatten) if types
    @data = collection.map do |record|
      url = url_for(:controller => record.resource_type.underscore.pluralize, :action => :show, :id => record.resource_id)
      {:type => record.resource_type, :id => record.resource_id, :title => record.phrase, :url => url}
    end
    respond_to do |format|
      format.json { render :text => @data.to_json }
    end
  end
end
