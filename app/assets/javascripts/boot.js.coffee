
window.OUT = {} unless window.OUT?

#
# Helper methods
#
OUT.cancelFormFor = (ele) ->
  $(ele).parents("form").find("a.cancel").click()

OUT.registerKeyboardShortcut = (key, cb) ->
  $('body').live "keypress", (event) ->
    char = String.fromCharCode(event.charCode)
    if event.target == this && char == key
      event.preventDefault()
      cb.apply(null, [event])

OUT.selectFirstInput = (ele) ->
  ele or= document
  $(ele).find("input[type=text], textarea").first().select()

#
# Handler & trigger methods
#
OUT.handlers = {} unless OUT.handlers?
OUT.HANDLER_ADDED_ITEM = "added-item"
OUT.HANDLER_DEACTIVATE_FORM = "deactivate-form"

OUT.registerHandler = (namespace, name, callback) ->
  OUT.handlers[namespace] = {} if OUT.handlers[namespace] == undefined
  OUT.handlers[namespace][name] = callback

OUT.registerAddedHandler = (name, callback) ->
  OUT.registerHandler OUT.HANDLER_ADDED_ITEM, name, callback

OUT.registerDeactivateFormHandler = (name, callback) ->
  OUT.registerHandler OUT.HANDLER_DEACTIVATE_FORM, name, callback

OUT.triggerHandler = (namespace, name, args) ->
  handlers = OUT.handlers[namespace]
  if callback = handlers[name]
    callback.apply(null, args)

#
# Ready & load handlers
#
$ ->
  OUT.selectFirstInput()

$(window).load ->
  $('form input[type="text"]').live "keydown", (event) ->
    if event.keyCode == 27
      OUT.cancelFormFor(this)
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

