require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  test "should delete favorite when item is deleted" do
    favorite = Favorite.first
    assert_not_nil favorite

    item = favorite.resource
    assert_not_nil item

    item.destroy
    assert !Favorite.exists?(favorite), "Favorite should be deleted when item is deleted"
  end
end
