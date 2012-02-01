# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

OUT.contentItems =
  hover_delay: 500
  hover_timeout_id: null

  createSortables: ->
    $('.content-items').sortable
      axis: 'y'
      handle: '.move-handle'
      cursor: 'crosshair'
      items: '> .content-item'
      scroll: true
      update: OUT.handlers.listSorted
      start: (event, ui) ->
      stop: (event, ui) ->
        OUT.contentItems.resetHoverClues()
      change: (event, ui) ->
        console.log("change", event.type, ui)
        t = $(".sortable-helper").draggable().data("draggable")
        $.ui.ddmanager.prepareOffsets(t, event)
        $(".sortable-helper").draggable("destroy")
      
  createDroppables: ->
    console.log "createContentItemDroppables"
    $('.content-item').droppable
      drop: OUT.contentItems.dropOnContentItem
      over: (event, ui) -> 
        is_placeholder = $(this).hasClass("ui-sortable-placeholder")
        if( !is_placeholder )
          OUT.contentItems.startHoverTimeout(ui.helper, this);
      out: (event, ui) ->
        is_placeholder = $(this).hasClass("ui-sortable-placeholder")
        if( !is_placeholder )
          OUT.contentItems.clearHoverTimeout(ui.helper, this);

  dropOnContentItem: (event, ui) ->
    draggable = ui.draggable[0]
    droppable = $(this)
    console.log "dropOnContentItem"
    if OUT.contentItems.validateHover(draggable, droppable)
      OUT.contentItems.onDrop(draggable, droppable)

  startHoverTimeout: (draggable, droppable) ->
    OUT.contentItems.hover_timeout_id = window.setTimeout(->
        if OUT.contentItems.validateHover(draggable, droppable)
          OUT.contentItems.onHover(draggable, droppable)
      , OUT.contentItems.hover_delay)

  clearHoverTimeout: (draggable, droppable) ->
    window.clearTimeout(OUT.contentItems.hover_timeout_id)
    OUT.contentItems.hover_timeout_id = null
    OUT.contentItems.resetHoverClues()

  #
  # is called, when an item is dropped over another
  #
  onDrop: (draggable, droppable) ->
    draggable_info = OUT.contentItems.getObjectInfo(draggable)
    droppable_info = OUT.contentItems.getObjectInfo(droppable)
    console.log "onDrop", draggable_info, droppable_info
    
  #
  # is called, when an item is hovered over another
  #
  onHover: (draggable, droppable) ->
    OUT.contentItems.showHoverClues(draggable, droppable)
    
  #
  # returns true, if the given draggable can be hovered over the given droppable
  #
  validateHover: (draggable, droppable) ->
    draggable_info = OUT.contentItems.getObjectInfo(draggable)
    droppable_info = OUT.contentItems.getObjectInfo(droppable)
    console.log "validateHover", droppable_info.type == draggable_info.type
    droppable_info.type == draggable_info.type
    
  #
  # resets all visual clues for hovering
  #
  resetHoverClues: ->
    $('.content-item').removeClass("drop-target").removeClass("droppable").find(".sortable-helper").remove();
    
  #
  # displays visual clues for hovering
  #
  showHoverClues: (draggable, droppable) ->
    console.log("showHoverClues", draggable, droppable);
    $(draggable).addClass("droppable");
    $(droppable).addClass("drop-target");
    helper = $(".sortable-helper").clone(true)
    $(droppable).prepend(helper);

  #
  # returns info about the object represented by the given dom element
  #
  getObjectInfo: (ele) ->
    dom_id = $(ele).attr("id")
    content_item_id = OUT.contentItems.splitDomId(dom_id)[1]

    dom_id = $(ele).find(".item-type").attr("id")
    [type, id] = OUT.contentItems.splitDomId(dom_id)

    info =
      element: ele
      content_item_id: content_item_id
      dom_id: dom_id
      type: type
      id: id

  #
  # splits a given dom_id, e.g. "project_2" in ["project", "2"]
  #
  splitDomId: (dom_id) ->
    arr = dom_id.match(/^(.+)\_(\d+)$/)
    [arr[1], arr[2]]

$ ->
  $("#add-content-item-tabs li.active").removeClass("active")
  $('#add-content-item-tabs').bind 'change', (e) ->
    pane = e.target.href.match(/(#.+)$/)[0]
    OUT.selectFirstInput(pane)
  