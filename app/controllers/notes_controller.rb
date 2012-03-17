class NotesController < ContentItemsController
  content_item_resources

  def collection_for_query(query)
    collection.where(["text LIKE ?", query])
  end
end
