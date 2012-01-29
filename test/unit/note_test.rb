require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  fixtures :content_items

  # test "the truth" do
  #   assert true
  # end
  setup do
    @note = Note.new
  end

  test "should move content_item with item" do
    item = Note.first
    content_item = item.content_item
    assert_not_nil content_item

    new_content = Content.last
    assert_not_nil new_content
    assert_not_equal item.outer_content, new_content

    item.content_id = new_content.id
    item.save

    assert_equal new_content, item.outer_content
    assert_equal new_content, content_item.content
  end

  test "responds to user" do
    assert_not_nil @note
    assert @note.respond_to?(:outer_content), "Project doesnot respond to :content"
  end

  test "Domain responds to pages" do
    assert Domain.first.respond_to?(:notes), "Domain doesnot respond to :pages"
  end

  test "saves and creates content" do
    @content_holder = Page.first
    assert_not_nil @content_holder
    assert_not_nil @content_holder.inner_content

    @note.user = User.first
    @note.domain = Domain.first
    @note.outer_content = @content_holder.inner_content
    @note.text = "Text"

    assert @note.save
    assert_not_nil @note.outer_content
    assert_not_nil @note.content_item

    assert_not_nil @note.content_item.content
    assert @note.content_item.content.holder == @content_holder, "Wrong content holder"
  end

  test "destroys content_item when destroyed" do
    @note = Note.first
    assert_not_nil @note

    @content_item = @note.content_item
    assert_not_nil @content_item
    @content = @content_item.content
    assert_not_nil @content

    @note.destroy
    assert_equal false, ContentItem.exists?(@content_item)
    assert_equal true, Content.exists?(@content)
  end

end
