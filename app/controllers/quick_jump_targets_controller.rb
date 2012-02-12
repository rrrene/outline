class QuickJumpTargetsController < ApplicationController
  before_filter :require_user

  def index
    phrase = params[:query].to_s
    phrase = phrase.split(/\s+/).join('%')
    phrase = "%#{phrase}%"
    collection = current_domain.quick_jump_targets.where(["phrase LIKE ?", phrase])
    @data = collection.map do |record|
      url = url_for(:controller => record.resource_type.underscore.pluralize, :action => :show, :id => record.resource_id)
      record.attributes.merge(:type => record.resource_type, :title => record.phrase, :url => url)
    end
    respond_to do |format|
      format.json { render :text => @data.to_json }
    end
  end
end
