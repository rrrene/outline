# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $(".btn.favorite-toggle").live "click", (event) ->
    selector = $(this).data("target")
    checkbox = $(selector).find('input[type=checkbox]')
    console.log checkbox
    checkbox.click()

    active = $(checkbox).is(":checked")
    klass = if active then "icon-favorite" else "icon-no-favorite"
    $(this).find("i").attr("class", klass)

    title_data = if active then "title-active" else "title-inactive"
    title = $(this).data(title_data)
    $(this).attr("title", title)

    true

  $('input[data-toggle="favorite"]').live "change", (event) ->
    $(this).parents("form").submit();
    active = $(this).is(":checked")
    klass = if active then "icon-favorite" else "icon-no-favorite"
    $(this).parents("form").find("i").attr("class", klass)