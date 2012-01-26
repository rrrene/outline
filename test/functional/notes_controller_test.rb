require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  should_act_as_content_item_resources

  def resource_attributes
    {:text => "A new note..."}
  end
end
