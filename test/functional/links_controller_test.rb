require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  should_act_as_content_item_resources

  def resource_attributes
    {:href => "www.example.org", :title => "Example Link", :text => "A new link..."}
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
