require 'test_helper'

class DomainControllerTest < ActionController::TestCase
  test "should GET dashboard" do
    with_login do |user|
      get :dashboard
      assert_response :success
    end
  end

  test "should GET settings" do
    with_login do |user|
      get :settings
      assert_response :success
    end
  end

  test "should update settings" do
    with_login do |user|
      hash = {:title => "New Title", :theme => "outline"}
      put :settings, :domain => hash
      assert_not_nil assigns["domain"]
      hash.each do |attribute, value|
        assert_equal value, assigns["domain"].send(attribute)
      end
      assert_response :success
    end
  end

end
