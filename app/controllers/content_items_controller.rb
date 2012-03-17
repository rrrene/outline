class ContentItemsController < ApplicationController

  def move_to_page
    @content_item = resource.content_item
    @page = current_domain.pages.accessible_by(current_ability).find(params[:page_id])
    @content_item.content_id = @page.inner_content.id
    @content_item.save
    @content_item.move_to_top
    respond_to do |format|
      format.html { redirect_to @page }
    end
  end
end
