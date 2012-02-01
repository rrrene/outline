# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

window.OUT.deactivateFormHandlers = {} unless window.OUT.deactivateFormHandlers?

window.OUT.deactivateFormHandlers["form.simple_form.todo"] = (form) ->
  OUT.selectFirstInput(form)
