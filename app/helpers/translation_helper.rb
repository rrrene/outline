module TranslationHelper
  def shared_snippet(suffix, options = {})
    snippet("shared", suffix, options)
  end

  def content_item_snippet(suffix, options = {})
    snippet("content_items", suffix, options)
  end

  def snippet(base, suffix, options = {})
    tt(controller_name+suffix, base+suffix, options)
  end

  def tt(*snippets)
    options = snippets.last.is_a?(Hash) ? snippets.pop : {}
    snippets.flatten!
    try_translation(snippets, options) || t(snippets.last)
  end
end