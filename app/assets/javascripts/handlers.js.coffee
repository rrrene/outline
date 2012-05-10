# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

OUT.handlers["listSorted"] = (event, ui) ->
  console.log "handlers.listSorted", $(this)
  url = $(this).attr("data-sort-url")
  data = $(this).sortable('serialize')
  $.ajax
    url: url
    data: data
    type: 'post'
    dataType: 'script'

$(window).load ->
  # When the ENTER key is pressed in a textfield inside a modal, click the primary button
  $(".modal input[type=text]").live "keypress", (event) ->
    if( event.which == 13 )
      modal = $(this).parents(".modal")
      primary = modal.find("input.btn-primary, a.btn-primary")
      primary.click()
      event.preventDefault();
      return false
