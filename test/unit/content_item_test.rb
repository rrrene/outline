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
end
