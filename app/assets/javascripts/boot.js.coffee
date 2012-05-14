
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
OUT.HANDLER_WILDCARD = "*"
OUT.HANDLER_CREATED_ITEM = "created-item"
OUT.HANDLER_UPDATED_ITEM = "updated-item"
OUT.HANDLER_DELETED_ITEM = "deleted-item"
OUT.HANDLER_DEACTIVATE_FORM = "deactivate-form"

OUT.created = (type, selector) ->
  console.log "OUT.created", arguments
  OUT.triggerAllHandlers OUT.HANDLER_CREATED_ITEM, type, [selector]

OUT.updated = (type, selector) ->
  console.log "OUT.updated", arguments
  OUT.triggerAllHandlers OUT.HANDLER_UPDATED_ITEM, type, [selector]

OUT.deleted = (type, selector) ->
  console.log "OUT.deleted", arguments
  OUT.triggerAllHandlers OUT.HANDLER_DELETED_ITEM, type, [selector]

OUT.registerHandler = (namespace, name, callback) ->
  OUT.handlers[namespace] = {} if OUT.handlers[namespace] == undefined
  OUT.handlers[namespace][name] = [] if OUT.handlers[namespace][name] == undefined
  OUT.handlers[namespace][name].push callback

OUT.registerCreatedHandler = (name, callback) ->
  OUT.registerHandler OUT.HANDLER_CREATED_ITEM, name, callback

OUT.registerUpdatedHandler = (name, callback) ->
  OUT.registerHandler OUT.HANDLER_UPDATED_ITEM, name, callback

OUT.registerDeletedHandler = (name, callback) ->
  OUT.registerHandler OUT.HANDLER_DELETED_ITEM, name, callback

OUT.registerDeactivateFormHandler = (name, callback) ->
  OUT.registerHandler OUT.HANDLER_DEACTIVATE_FORM, name, callback

OUT.triggerAllHandlers = (namespace, name, args) ->
  OUT.triggerHandler namespace, name, args
  OUT.triggerHandler namespace, OUT.HANDLER_WILDCARD, args
  OUT.triggerHandler OUT.HANDLER_WILDCARD, name, args
  OUT.triggerHandler OUT.HANDLER_WILDCARD, OUT.HANDLER_WILDCARD, args

OUT.triggerHandler = (namespace, name, args) ->
  handlers = OUT.handlers[namespace]
  if handlers
    if callbacks = handlers[name]
      callback.apply(null, args) for callback in callbacks


#
# Ready & load handlers
#
$ ->
  OUT.selectFirstInput()
  $('#ajax-active').ajaxSend ->
    $(this).show()
  .ajaxComplete ->
    $(this).hide()

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
