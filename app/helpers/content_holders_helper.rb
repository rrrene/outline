module ContentHoldersHelper
  def content_holder
    resource if resource.respond_to?(:content)
  end
end
