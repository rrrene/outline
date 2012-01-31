require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create activity upon page creation" do
    Thread.current[:activity_user] = User.first
    assert_created(Activity) do
      page = Page.create(:user_id => 1, :domain_id => 1, :title => "A new page")
      assert page.save
    end
  end
end
