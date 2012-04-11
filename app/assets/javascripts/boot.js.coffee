
window.OUT = {} unless window.OUT?

OUT.registerKeyboardShortcut = (key, cb) ->
  $('body').live "keypress", (event) ->
    char = String.fromCharCode(event.charCode)
    if event.target == this && char == key
      event.preventDefault()
      cb.apply(null, [event])

OUT.selectFirstInput = (ele) ->
  ele or= document
  $(ele).find("input[type=text], textarea").first().select()

$ ->
  OUT.selectFirstInput()

$(window).load ->
  $('form input[type="text"]').live "keyup", (event) ->
    if event.keyCode == 27
      $(this).parents("form").find("a.cancel").click()
      event.stopImmediatePropagation()
      event.preventDefault()
      false

  #
  # Submit a textarea on ctrl+enter
  #
  $("textarea").live "keydown", (event) ->
    if event.keyCode == 13 && event.ctrlKey
      $(event.target).parents("form").submit()

  $('[data-submit="form"]').live "change", (event) ->
    $(event.target).parents("form").submit()

