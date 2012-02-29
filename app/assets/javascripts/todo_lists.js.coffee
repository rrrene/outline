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

  title = $(".content-items").data("filter-title")
  if title?
    regex = new RegExp("(#{title})", "gi")
    $(".content-items .content-item-todo-list h2, .content-items .todo-title").each ->
      old_html = $(this).html()
      if old_html.match regex
        # $(this).addClass "filter-matched"
        $(this).html old_html.replace(regex, '<span class="highlight">$1</span>')