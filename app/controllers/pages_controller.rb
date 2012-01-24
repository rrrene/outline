class PagesController < ApplicationController
  content_holder_resources

  def sort_content
    order = params[:content_item]
    order.map!(&:to_i)
    content_items = ContentItem.where(:id => order)
    content_items.each do |content_item|
      content_item.update_attribute :position, order.index(content_item.id) + 1 
    end
    render :text => ""
  end
end
