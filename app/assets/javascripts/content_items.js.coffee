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

$ ->
  OUT.contentItems.createSortables()

  $('a[data-toggle="content-item-form"]').bind "click", (event) ->
    selector = $(event.target).data('target')
    $(selector).toggle(); 
    OUT.selectFirstInput(selector)
    false

  # $("#add-content-item-tabs li.active").removeClass("active")
  $('#add-content-item-tabs').bind 'shown', (event) ->
    pane = event.target.href.match(/(#.+)$/)[0]
    OUT.selectFirstInput(pane)