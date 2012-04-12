require 'test_helper'

class DomainTest < ActiveSupport::TestCase
  test "should give tags" do
    domain = Domain.first
    assert !domain.tags.nil?
  end

  test "should give tags for pages" do
    domain = Domain.first
    assert !domain.tags_for(:pages).nil?
  end

  test "should kill everything when destroyed" do
    models = [Activity, Context, Content, ContentItem]
    models.concat [User, Favorite, QuickJumpTarget]
    models.concat [Project, Page]
    models.concat Outline::ContentItems.classes
    assert Domain.count > 0
    models.each do |model|
      assert model.count > 0, "#{model}.count == 0"
    end

    Domain.destroy_all

    models.each do |model|
      assert model.count == 0, "#{model} has not been destroyed"
    end
  end

end
