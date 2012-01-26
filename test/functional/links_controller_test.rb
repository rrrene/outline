require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  should_act_as_content_item_resources

  def resource_attributes
    {:href => "www.example.org", :title => "Example Link", :text => "A new link..."}
  end
end
