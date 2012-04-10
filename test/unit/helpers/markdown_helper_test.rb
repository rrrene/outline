# Original code for 'github flavored markdown' can be found here:
#   https://gist.github.com/118964
# Explanation:
#   http://github.github.com/github-flavored-markdown/
#

require 'test_helper'

class MarkdownHelperTest < ActionView::TestCase
  test "should not touch single underscores inside words" do
    assert_equal "foo_bar", gfm("foo_bar")
  end

  test "should not touch underscores in code blocks" do
    assert_equal "    foo_bar_baz", gfm("    foo_bar_baz")
  end

  test "should not touch underscores in pre blocks" do
    assert_equal "\n\n<pre>\nfoo_bar_baz\n</pre>", gfm("<pre>\nfoo_bar_baz\n</pre>")
  end

  test "should not treat pre blocks with pre-text differently" do
    a = "\n\n<pre>\nthis is `a\\_test` and this\\_too\n</pre>"
    b = "hmm<pre>\nthis is `a\\_test` and this\\_too\n</pre>"
    assert_equal gfm(a)[2..-1], gfm(b)[3..-1]
  end

  test "should turn newlines into br tags in simple cases" do
    assert_equal "foo  \nbar", gfm("foo\nbar")
  end

  test "should convert newlines in all groups" do
    assert_equal "apple  \npear  \norange\n\nruby  \npython  \nerlang",
                 gfm("apple\npear\norange\n\nruby\npython\nerlang")
  end

  test "should convert newlines in even long groups" do
    assert_equal "apple  \npear  \norange  \nbanana\n\nruby  \npython  \nerlang",
                 gfm("apple\npear\norange\nbanana\n\nruby\npython\nerlang")
  end

  test "should not convert newlines in lists" do
    assert_equal "# foo\n# bar", gfm("# foo\n# bar")
    assert_equal "* foo\n* bar", gfm("* foo\n* bar")
  end
end
