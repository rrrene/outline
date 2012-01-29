require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "content_item_ids= should apply order" do
    content = Content.first
    assert content.content_items.count > 1

    ids = content.content_items.map(&:id)
    content.content_item_ids = ids.reverse.map(&:to_s)
    assert_not_equal ids, content.reload.content_items.map(&:id)
    assert_equal ids.reverse, content.content_items.map(&:id)
  end
end
