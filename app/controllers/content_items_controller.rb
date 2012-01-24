class ContentItemsController < AuthorizedController
  def create
    create_user_owned_resource
    create! do |format|
      if resource.save
        format.html { redirect_to resource.content.holder }
      else
        raise resource.errors.full_messages.inspect
      end
    end
  end
end
