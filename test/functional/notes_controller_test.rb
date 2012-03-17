require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  should_act_as_content_item_resources

  def resource_attributes
    {:text => "A new note..."}
  end

  test "should GET index with project" do
    with_login do |user|
      get :index, :project_id => 1
      assert_response :success
    end
  end

  test "should GET index with query" do
    with_login do |user|
      get :index, :query => "test"
      assert_response :success
    end
  end

end
