class ProjectsController < ApplicationController
  authorized_resources
  enable_bulk_actions :add_tags, :activate, :deactivate, :destroy
  before_filter :set_page_header, :only => [:new, :create, :edit, :update, :show]

  def todo_lists
    @content_items = ContentItem.where(:content_id => current_project.content_ids, :item_type => :TodoList).includes(:item).order("updated_at DESC")
    @rejected = @content_items.reject! do |content_item|
      content_item.item.active_todos.count == 0
    end
  end

  protected

  def collection_for_scope(scope)
    case scope
      when 'active'
        collection.where(:active => true)
      when 'inactive'
        collection.where(:active => false)
      else
        collection
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
