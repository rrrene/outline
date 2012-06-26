# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

OUT.registerCreatedHandler "todo_list", (selector) ->
  $(selector).find("a.new").click()

# TODO: doesnot work when user clicks on "cancel" (triggers :show action, no update)
OUT.registerUpdatedHandler "todo_list", (selector) ->
  OUT.todo_lists.flattenTitleLinks(selector)

OUT.todo_lists =
  # Remove links to todo-list from todo-lists in content area
  flattenTitleLinks: (root = '.content') ->
    $(root).find('h2 a[rel="todo-list"]').each ->
      $(this).replaceWith $(this).html()

$ ->
  OUT.todo_lists.flattenTitleLinks()


  OUT.contentItems.highlightQueryIn ".content-items .content-item-todo-list h2, .content-items .todo-title", (chain) ->
    matched_lists = $(".content-items .content-item-todo-list h2 span.highlight").parents('.content-item-todo-list')
    matched_lists.find('.content-item').show()

$(window).load ->
  $('.content-todo-list.sortable').sortable
    connectWith: ".content-todo-list.sortable"
