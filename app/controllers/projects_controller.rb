class ProjectsController < ApplicationController
  authorized_resources
  enable_bulk_actions :add_tags, :activate, :deactivate, :destroy
  before_filter :set_page_header, :only => [:new, :create, :edit, :update, :show]

  def todo_lists
    @content_items = ContentItem.where(:content_id => resource.pages.map(&:inner_content).map(&:id), :item_type => :TodoList).includes(:item)
    @rejected = @content_items.reject! do |content_item|
      content_item.item.active_todos.count == 0
    end
  end

  protected
  
  def filter_collection
    filter_by_title
    if scope = params[:scope].presence
      self.collection = collection.where(:active => true) if scope == 'active'
      self.collection = collection.where(:active => false) if scope == 'inactive'
    end
  end

  def order_by
    "UPPER(title) ASC"
  end

  def set_page_header
    @page_header = resource.try(:title)
    @page_hint = resource.try(:description)
  end

end
