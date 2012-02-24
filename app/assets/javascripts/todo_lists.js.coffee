# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.content-todo-list').sortable
    connectWith: ".content-todo-list"

  # Remove links to todo-list from todo-lists in content area
  $('.content h2 a[rel="todo-list"]').each ->
    $(this).parent().html $(this).html()