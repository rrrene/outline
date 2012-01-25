# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

OUT.initializers = 
  createContentItemDroppables: ->
    console.log "createContentItemDroppables"
    $('.content-item').droppable
      hoverClass: 'ui-state-highlight'
      drop: OUT.handlers.dropOnContentItem
      over: (event, ui) -> 
        is_placeholder = $(this).hasClass("ui-sortable-placeholder")
        if( !is_placeholder )
          console.log("over", event.type, ui, $(this))
      out: (event, ui) ->
        is_placeholder = $(this).hasClass("ui-sortable-placeholder")
        if( !is_placeholder )
          console.log "over", event.type, ui, $(this)
  selectFirstInput: ->
    $("form.simple_form input[type=text]").select();