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
      puts @data.inspect
      assert @data.any? { |item| item["type"] == "project" }
      assert @data.any? { |item| item["type"] == "page" }
    end
  end

  test "should render json on pages" do
    with_login do |user|
      get :pages, :format => :json, :query => "first"
      @data = assigns['data']
      assert_not_nil @data
      assert !@data.empty?
      puts @data.inspect
      assert @data.all? { |item| item["type"] == "page" }
    end
  end
end
