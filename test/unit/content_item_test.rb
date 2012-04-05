require 'test_helper'

class ContentItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should move item with content_item" do
    content_item = ContentItem.first
    item = content_item.item
    assert_not_nil item

    new_content = Content.last
    assert_not_nil new_content
    assert_not_equal content_item.content, new_content

    content_item.content_id = new_content.id
    content_item.save

    assert_equal new_content, content_item.content
    assert_equal new_content, item.outer_content
  end

  test "should delete content items if domain is destroyed" do
    content_item = ContentItem.first
    assert_not_nil content_item
    item = content_item.item
    assert_not_nil item

    domain = item.domain
    assert_not_nil domain

    domain.destroy

    assert !item.class.exists?(item), "Item should be destroyed"
    assert !content_item.class.exists?(content_item), "ContentItem should be destroyed"
  end

end
