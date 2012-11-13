# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?


OUT.pages =
  showModal: (title = "", auto_submit = false) ->
    m = $('#new-page-modal')
    if title != ""
      m.find("input#page_title").val(title)
    if auto_submit
      m.find("form").submit()
    else
      m.modal('show')

$(window).load ->
  $('#page_context_id').live 'change', ->
    new_project_fields = $('#add-to-new-project')
    if $(this).val() == "-1"
      new_project_fields.show()
      OUT.selectFirstInput(new_project_fields)
    else
      new_project_fields.hide()

$ ->
  OUT.contentItems.highlightQueryIn(".content-items .content-item-page .content-item-body")