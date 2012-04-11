require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  test "should create favorite" do
    with_login do |user|
      favorites = Favorite.where(:resource_type => "Project", :resource_id => 1)
      assert_equal 0, favorites.count
      post :set, :favorite => {:resource_type => "Project", :resource_id => 1}, :active => "true"
      assert_equal 1, favorites.count
    end
  end

  test "should NOT create favorite for user in another domain" do
    with_login do |user|
      favorites = Favorite.where(:resource_type => "Page", :resource_id => 2)
      assert_equal 1, favorites.count
      post :set, :favorite => {:resource_type => "Page", :resource_id => 2}, :active => "true"
      assert_equal 1, favorites.count
    end
  end

  test "should NOT create a new favorite" do
    with_login do |user|
      favorites = Favorite.where(:resource_type => "Page", :resource_id => 1)
      assert_equal 1, favorites.count
      post :set, :favorite => {:resource_type => "Page", :resource_id => 1}, :active => "true"
      assert_equal 1, favorites.count
    end
  end

  test "should remove favorite" do
    with_login do |user|
      favorites = Favorite.where(:resource_type => "Page", :resource_id => 1)
      assert favorites.count > 0, "There has to be a matching favorite"
      post :set, :favorite => {:resource_type => "Page", :resource_id => 1}
      assert_equal 0, favorites.count
    end
  end
end
