require 'test_helper'

class QuickJumpTargetsControllerTest < ActionController::TestCase
  setup do
    QuickJumpTarget.update_all Project, Page
  end

  test "should render json on index" do
    with_login do |user|
      get :index, :format => :json, :query => "first"
      @data = assigns['data']
      assert_not_nil @data
      assert !@data.empty?
      assert @data.any? { |item| item["type"] == "Project" }
      assert @data.any? { |item| item["type"] == "Page" }
    end
  end

  test "should render json on pages" do
    with_login do |user|
      get :pages, :format => :json, :query => "first"
      @data = assigns['data']
      assert_not_nil @data
      assert !@data.empty?
      assert @data.all? { |item| item["type"] == "Page" }
    end
  end
end
