
module UserTextHelper
  include MarkdownHelper

  # Formats multi-line user text (like descriptions)
  def format_multi_line_user_input(text)
    text = auto_link gfm(text) # uses GitHub flavored markdown from MarkdownHelper
    sanitize RDiscount::new(text).to_html
  end

  # Formats single line user text (like titles)
  def inline_user_text(text)
    sanitize(auto_link(text.to_s))
  end

  def user_text(text)
    find_and_preserve format_multi_line_user_input(text).html_safe
  end
end