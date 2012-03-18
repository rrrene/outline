class LinksController < ContentItemsController
  content_item_resources

  def collection_for_query(query)
    collection.where(["title LIKE ? OR href LIKE ? OR text LIKE ?", query, query, query])
  end
end
