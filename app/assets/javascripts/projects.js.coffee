# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?


OUT.projects =
  showModal: (title = "", auto_submit = false) ->
    m = $('#new-project-modal')
    if title != ""
      m.find("input#project_title").val(title)
    if auto_submit
      m.find("form").submit()
    else
      m.modal('show')
