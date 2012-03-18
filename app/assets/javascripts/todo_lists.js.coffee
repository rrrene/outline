# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.content-todo-list').sortable
    connectWith: ".content-todo-list"

  # Remove links to todo-list from todo-lists in content area
  $('.content h2 a[rel="todo-list"]').each ->
    $(this).parent().html $(this).html()
    # TODO: doesnot work with live added data

  title = $("ul.content-items").data("filter-query")
  if title?
    regex = new RegExp("(#{title})", "gi")
    $(".content-items .content-item-todo-list h2, .content-items .todo-title").each ->
      if $(this).html().match regex
        $(this).parents('.content-item').addClass "filter-matched"
        $(this).highlight title
    
    $('.content-item-todo-list').hide().filter('.filter-matched').show()
    matched_lists = $(".content-items .content-item-todo-list h2 span.highlight").parents('.content-item-todo-list')
    matched_lists.find('.content-item').show()
