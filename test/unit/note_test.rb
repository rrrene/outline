require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @note = Note.new
  end

  test "responds to user" do
    assert_not_nil @note
    assert @note.respond_to?(:content), "Project doesnot respond to :content"
  end

  test "Domain responds to pages" do
    assert Domain.first.respond_to?(:notes), "Domain doesnot respond to :pages"
  end

  test "saves and creates content" do
    @content_holder = Page.first
    assert_not_nil @content_holder
    assert_not_nil @content_holder.content

    @note.user = User.first
    @note.domain = Domain.first
    @note.content = @content_holder.content
    @note.text = "Text"
    assert @note.save
    assert_not_nil @note.content
    assert_not_nil @note.content_item

    assert_not_nil @note.content_item.content
    assert @note.content_item.content.holder == @content_holder, "Wrong content holder"
  end

end
