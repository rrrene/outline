# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

window.OUT.deactivateFormHandlers = {} unless window.OUT.deactivateFormHandlers?

window.OUT.deactivateFormHandlers["form.simple_form.todo"] = (form) ->
  OUT.selectFirstInput(form)

OUT.todos =
  initialize: ->
    $(".todo-checkbox").bind "change", (event) ->
      console.log "checkbox.change", $(event.target).val()
      $(event.target).parents(".content-item").addClass("pending")
      checked = $(event.target).is(':checked')
      data = {"active": !checked}
      url = $(event.target).data("url")
      $.ajax
        url: url
        data: data
        type: 'post'
        dataType: 'script'

$ ->
  OUT.todos.initialize();