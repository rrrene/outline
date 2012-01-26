
module TestLoginHelper
  # Add more helper methods to be used by all tests here...
  
  def assert_login_required(user = standard_user, &block)
    yield(user)
    assert_response :redirect
    login!(user)
    yield(user)
  end
  
  def assert_login_required_for(action, parameters = {})
    assert_login_required do
      get action, parameters
    end
  end
  
  def assert_no_login_required(user = standard_user, &block)
    yield(user)
    assert_response :success
  end
  
  def assert_no_login_required_for(*actions)
    actions.each do |action|
      assert_no_login_required do
        get action
      end
    end
  end
  
  def login!(user = standard_user)
    UserSession.create(user)
  end
  
  def logout!
    UserSession.find.try(:destroy)
  end
  
  def with_login(user = standard_user, &block)
    login!(user)
    yield(user)
    logout!
  end
  
  private
  
  def standard_user
    users(:admin)
  end
end