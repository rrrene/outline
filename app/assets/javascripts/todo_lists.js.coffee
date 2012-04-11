# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT.addedHandlers = {} unless window.OUT.addedHandlers?

window.OUT.addedHandlers["todo_list"] = (selector) ->
  $(selector).find("a.new").click()

$ ->
  # Remove links to todo-list from todo-lists in content area
  $('.content h2 a[rel="todo-list"]').each ->
    $(this).parent().html $(this).html()
    # TODO: doesnot work with live added data

  OUT.contentItems.highlightQueryIn ".content-items .content-item-todo-list h2, .content-items .todo-title", (chain) ->
    matched_lists = $(".content-items .content-item-todo-list h2 span.highlight").parents('.content-item-todo-list')
    matched_lists.find('.content-item').show()

$(window).load ->
  $('.content-todo-list.sortable').sortable
    connectWith: ".content-todo-list.sortable"
