
window.OUT = {} unless window.OUT?

OUT.registerKeyboardShortcut = (key, cb) ->
  $('body').bind "keypress", (event) ->
    char = String.fromCharCode(event.charCode)
    if event.target == this && char == key
      event.preventDefault()
      cb.apply(null, [event])

OUT.selectFirstInput = (ele) ->
  ele or= document
  $(ele).find("input[type=text], textarea").first().select()

$ ->
  OUT.selectFirstInput()
  
  #
  # Submit a textarea on ctrl+enter
  #
  $("textarea").bind "keydown", (event) ->
    if event.keyCode == 13 && event.ctrlKey
      $(event.target).parents("form").submit()

  $('[data-submit="form"]').bind "change", (event) ->
    $(event.target).parents("form").submit()