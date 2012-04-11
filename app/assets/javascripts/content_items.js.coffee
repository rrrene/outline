# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

window.OUT.deactivateFormHandlers = {} unless window.OUT.deactivateFormHandlers?
window.OUT.addedHandlers = {} unless window.OUT.addedHandlers?

OUT.contentItems =
  added: (selector, type) ->
    if handler = OUT.addedHandlers[type]
      handler(selector)

  createSortables: ->
    $('.content-items.sortable').sortable
      axis: 'y'
      handle: '.move-handle'
      cursor: 'crosshair'
      items: '> .content-item'
      scroll: true
      update: OUT.handlers.listSorted

  deactivateForm: (form_selector, content_selector) ->
    $(form_selector).find("input[type=text], textarea").val("").blur()
    if handler = OUT.deactivateFormHandlers[form_selector]
      handler(form_selector, content_selector)

  highlightQueryIn: (items_selector, after_callback) ->
    query = $("ul.content-items").data("filter-query")
    if query? && query != ""
      regex = new RegExp("(#{query})", "gi")
      $(items_selector).each ->
        if $(this).html().match regex
          $(this).parents('.content-item').addClass "filter-matched"
          $(this).highlight query

      chain = $('.content-item').hide().filter('.filter-matched').show()
      after_callback.apply(null, [chain]) if after_callback?


  open: (select) ->
    details = $(select).find('.content-item-details')
    details.animate
      'display': 'block'
      'height': 16
      'opacity': 1
      , "slow"
    ele = $(select).animate
      'margin-top': "20"
      'margin-bottom': "20"
      , "slow"

  setAddFormArrowTo: (anchor) ->
    pane = $(anchor).attr("href")
    if pane?
      arrow_width = 16
      arrow_left_global = $(anchor).parent().offset().left + $(anchor).parent().width() / 2
      arrow_left_local = arrow_left_global - $(pane).offset().left
      arrow_left = arrow_left_local - arrow_width / 2
      $(pane).css("background-position", arrow_left+"px 0")

$ ->
  OUT.contentItems.setAddFormArrowTo $("#add-content-item-tabs li.active a")

  $("#add-content-item-tabs li.active").removeClass("active")

$(window).load ->
  OUT.contentItems.createSortables()

  $('a[data-toggle="content-item-form"]').live "click", (event) ->
    selector = $(event.target).data('target')
    $(selector).toggle();
    OUT.selectFirstInput(selector)
    $(this).hide()
    false

  $('#add-content-item-tabs').bind 'shown', (event) ->
    OUT.contentItems.setAddFormArrowTo $(event.target)
    pane = $(event.target).attr("href")
    if pane?
      OUT.selectFirstInput($(pane))

  $('a[data-toggle="move-to-page"]').live "click", (event) ->
    $("body").click()
    url = $(this).attr("href")
    quickjump = new OUT.QuickJump (selected) ->
        $.ajax
          type: 'POST'
          url: url
          data: {"page_id": selected.id}
          success: () ->
            quickjump.hide()
      , "/quick_jump_targets/pages.json"
    false
