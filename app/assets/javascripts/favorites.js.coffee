# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('input[data-toggle="favorite"]').bind "change", (event) ->
    $(this).parents("form").submit();
    active = $(this).is(":checked")
    klass = if active then "icon-favorite" else "icon-no-favorite"
    console.log $(this).val(), active, klass
    $(this).parents("form").find("i").attr("class", klass)