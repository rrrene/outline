# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

window.OUT.deactivateFormHandlers = {} unless window.OUT.deactivateFormHandlers?

window.OUT.deactivateFormHandlers["form.simple_form.todo"] = (form_selector, content_selector) ->
  console.log form_selector, content_selector
  $(content_id).find("form.todo input").val('').select()

OUT.todos =
  initialize: ->
    $("form.todo").bind "ajax:beforeSend", (event,xhr,status) ->
      console.log event,xhr,status
      $(event.target).find('input[type="text"]').val('').select()

    $(".todo-checkbox input").bind "change", (event) ->
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