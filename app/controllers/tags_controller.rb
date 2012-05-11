class TagsController < ApplicationController
  def update
    @tag = current_domain.tags.find(params[:id])
    @tag.update_attributes(params[:tag])
    redirect_to params[:"return-to"].presence || root_url
  end
end
