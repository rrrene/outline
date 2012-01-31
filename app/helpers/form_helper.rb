module FormHelper
  def cancel_path(resource = nil)
    if resource
      resource_path(resource)
    else
      collection_path
    end
  end
end