require 'test_helper'

class UserTextHelperTest < ActionView::TestCase
  include Haml::Helpers

  test "inline_user_text should leave original text" do
    original = "This is a test"
    assert_equal original, inline_user_text(original)

    original = "This is a <b>test</b>"
    assert_equal original, inline_user_text(original)

    original = "This is a **test**"
    assert_equal original, inline_user_text(original)
  end
end
