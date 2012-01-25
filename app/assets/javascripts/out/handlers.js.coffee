# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

OUT.handlers =
  listSorted: (event, ui) ->
    console.log "handlers.listSorted", $(this)
    url = $(this).attr("data-sort-url")
    data = $(this).sortable('serialize')
    $.ajax
      url: url
      data: data
      type: 'post'
      dataType: 'script'
   
  dropOnContentItem: (event, ui) ->
    dragged_id = ui.draggable[0].id
    dropped_id = $(this).attr("id")
    console.log "handlers.dropOnContentItem", dragged_id, " -> ", dropped_id
