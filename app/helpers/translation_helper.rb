module TranslationHelper
  def shared_snippet(suffix, options = {})
    tt(controller_name+suffix, "shared"+suffix, options)
  end
  
  def tt(*snippets)
    options = snippets.last.is_a?(Hash) ? snippets.pop : {}
    try_translation(snippets, options) || t(snippets.last)
  end
end