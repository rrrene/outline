module FormHelper
  def cancel_path
    if defined?(resource)
      resource_path(resource)
    else
      collection_path
    end
  end
end