# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

window.OUT.deactivateFormHandlers = {} unless window.OUT.deactivateFormHandlers?

OUT.contentItems =
  createSortables: ->
    $('.content-items.sortable').sortable
      axis: 'y'
      handle: '.move-handle'
      cursor: 'crosshair'
      items: '> .content-item'
      scroll: true
      update: OUT.handlers.listSorted

  deactivateForm: (selector) ->
    $(selector).find("input[type=text], textarea").val("").blur()
    if handler = OUT.deactivateFormHandlers[selector]
      handler($(selector))

  open: (select) ->
    ele = $(select).animate
      'margin-top': "20"
      'margin-bottom': "20"
      , "slow"

  setAddFormArrowTo: (anchor) ->
    pane = $( $(anchor).attr("href") )
    if pane?
      arrow_left_global = anchor.parent().offset().left + anchor.parent().width() / 2
      arrow_left_local = arrow_left_global - pane.offset().left
      arrow_width = 16
      arrow_left = arrow_left_local - arrow_width / 2
      $(pane).css("background-position", arrow_left+"px 0")

$ ->
  OUT.contentItems.createSortables()

  $('a[data-toggle="content-item-form"]').bind "click", (event) ->
    selector = $(event.target).data('target')
    $(selector).toggle(); 
    OUT.selectFirstInput(selector)
    false

  $('#add-content-item-tabs').bind 'shown', (event) ->
    OUT.contentItems.setAddFormArrowTo $(event.target)
    pane = $(event.target).attr("href")
    if pane?
      OUT.selectFirstInput($(pane))

  $('a[data-toggle="move-to-page"]').bind "click", (event) ->
    $("body").click()
    url = $(event.target).attr("href")
    quickjump = new OUT.QuickJump (selected) ->
      $.ajax
        type: 'POST'
        url: url
        data: {"page_id": selected.id}
        success: () ->
          quickjump.hide()
    , "/quick_jump_targets/pages.json"
    false

  OUT.contentItems.setAddFormArrowTo $("#add-content-item-tabs li.active a")

  $("#add-content-item-tabs li.active").removeClass("active")
