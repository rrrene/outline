class FavoritesController < ApplicationController
  authorized_resources

  def set
    @favorite = Favorite.new(params[:favorite])
    @create = params[:active] == "true"
    @resource = if @create
      current_user.favor(@favorite.resource)
    else
      current_user.unfavor(@favorite.resource)
    end
    respond_to do |format|
      format.html { redirect_to resource }
      format.js
    end
  end
end
