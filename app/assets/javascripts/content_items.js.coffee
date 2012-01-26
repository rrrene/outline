# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#add-content-item-tabs li.active").removeClass("active")
  $('#add-content-item-tabs').bind 'change', (e) ->
    pane = e.target.href.match(/(#.+)$/)[0]
    OUT.selectFirstInput(pane)
  