# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

OUT.bulk = 
  allCheckboxes: ->
    $("#bulk_collection .checkbox input")
  execute: (action, ele, confirm_msg) ->
    console.log action, ele, confirm_msg
    jQuery('#bulk_action').val(action);
    if !confirm_msg || confirm(confirm_msg)
      # OUT.loadingElement(ele);
      jQuery('#bulk_form').submit()
  selectAll: ->
    OUT.bulk.allCheckboxes().attr("checked", "checked")
    OUT.bulk.markSelected();
  selectNone: ->
    OUT.bulk.allCheckboxes().attr("checked", "")
    OUT.bulk.markSelected();
  markSelected: ->
    all_rows = OUT.bulk.allCheckboxes().parents(".row")
    all_rows.removeClass("active")
    checked_rows = all_rows.find("input:checked").parents(".row")
    checked_rows.addClass("active")
    if checked_rows.length > 0 
      $("#bulk_collection #no_items_selected").hide()
      $("#bulk_collection #items_selected").show()
    else
      $("#bulk_collection #no_items_selected").show()
      $("#bulk_collection #items_selected").hide()


$ ->
  OUT.bulk.allCheckboxes().bind "change", ->
    OUT.bulk.markSelected();