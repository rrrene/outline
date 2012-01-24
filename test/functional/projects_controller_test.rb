require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "get index" do
    get :index
  end
end
