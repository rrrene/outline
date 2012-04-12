# encoding: utf-8

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = Domain.first.users.first
  end

  test "should create favorite with favor" do
    Favorite.destroy_all
    assert_equal 0, Favorite.count
    @user.favor Domain.first.projects.first
    assert_equal 1, Favorite.count
  end

  test "should NOT create favorite for item in another domain" do
    Favorite.destroy_all
    assert_equal 0, Favorite.count
    @user.favor Domain.where(:id => 2).first.projects.first
    assert_equal 0, Favorite.count
  end

  test "should NOT create new favorite for already favored items" do
    resource = @user.favorites.first.resource
    chain = @user.favorites.where(:resource_type => resource.class, :resource_id => resource.id)
    old_count = chain.count
    @user.favor resource
    assert_equal old_count, chain.count
  end

  test "should destroy favorite with unfavor" do
    resource = @user.favorites.first.resource
    chain = @user.favorites.where(:resource_type => resource.class, :resource_id => resource.id)
    assert_equal 1, chain.count
    @user.unfavor resource
    assert_equal 0, chain.count
  end

  test "should give true/false for favors?" do
    resource = @user.favorites.first.resource
    assert_equal true, @user.favors?(resource)
    Favorite.destroy_all
    assert_equal false, @user.favors?(resource)
  end

  test "should give full name if present" do
    @user.update_attributes(:first_name => "René", :last_name => "Föhring", :login => "rene")
    assert_equal "René Föhring", @user.name

    @user.update_attributes(:first_name => "René", :last_name => "", :login => "rene")
    assert_equal "René", @user.name

    @user.update_attributes(:first_name => "", :last_name => "Föhring", :login => "rene")
    assert_equal "Föhring", @user.name

    @user.update_attributes(:first_name => "", :last_name => "", :login => "rene")
    assert_equal "rene", @user.name
  end
end
