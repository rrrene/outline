# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

window.OUT.deactivateFormHandlers = {} unless window.OUT.deactivateFormHandlers?

window.OUT.deactivateFormHandlers["form.simple_form.todo"] = (form_selector, content_selector) ->
  add_form_selector = $(content_selector).parents("*[data-add-form]").data("add-form")
  $(add_form_selector).find('input[type="text"]').val('').select()

$ ->
  $("form.todo").live "ajax:beforeSend", (event,xhr,status) ->
    $(event.target).find('input[type="text"]').val('').select()

  $(".todo-checkbox input").live "change", (event) ->
    $(event.target).parents(".content-item").addClass("pending")
    checked = $(event.target).is(':checked')
    data = {"active": !checked}
    url = $(event.target).data("url")
    $.ajax
      url: url
      data: data
      type: 'post'
      dataType: 'script'