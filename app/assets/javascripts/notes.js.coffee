# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  # $("#top-add-content-item-form form.note").addClass "active"

  $("#top-add-content-item-form form.note div.text textarea").bind "focus", ->
    $(this).parents("form.note").addClass "active"
  .bind "blur", ->
    if( $(this).val() == "" )
      $(this).parents("form.note").removeClass "active"
  .blur()

  OUT.contentItems.highlightQueryIn(".content-items .content-item-note .content-item-body")