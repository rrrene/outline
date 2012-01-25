require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  
  test "should GET new" do
    assert_no_login_required_for :new
  end

  test "should login via #create" do
    post :create, :user_session => {:login => "admin", :password => 'asdf'}
    assert_response :redirect
    assert_not_nil UserSession.find.presence
  end
  
  test "should NOT login via #create with wrong password" do
    post :create, :user_session => {:login => "admin", :password => 'something'}
    assert_response :success
    assert_nil UserSession.find.presence
  end

  test "should logout via #destroy" do
    login!
    assert_not_nil UserSession.find.presence
    
    get :destroy

    assert_response :redirect
    assert_nil UserSession.find.presence
  end
  
end
