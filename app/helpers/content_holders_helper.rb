module ContentHoldersHelper
  def content_holder
    resource = controller.method(:resource).call
    resource if resource.respond_to?(:inner_content)
  end
end
