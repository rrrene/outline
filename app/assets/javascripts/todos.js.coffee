# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

OUT.registerDeactivateFormHandler "form.todo", (form_selector, content_selector) ->
  add_form_selector = $(content_selector).parents("*[data-add-form]").data("add-form")
  $(add_form_selector).find('input[type="text"]').val('').select()

OUT.registerAddedHandler "todo", (selector) ->
  $("li.dummy-todo").remove()

OUT.todos =
  createFakeTodo: (ele) ->
    title = $(ele).find('input[type="text"]').val()
    if title? && title != ""
      html = '<li class="content-item content-item-todo dummy-todo">' +
        '<div class="content-item-wrapper item-type">' +
          '<div class="content-item-inner">' +
            '<div class="content-item-body">' +
              '<div class="todo-checkbox"><input type="checkbox" disabled="disabled"></div>' +
              '<div class="todo-title">'+title+'</div>' +
              '<div class="clearboth"></div>' +
            '</div>' +
          '</div>' +
        '</div>' +
        '<div class="spacer"><hr></div>' +
      '</li>'

      list = $(ele).parents(".content-item-todo-list").find("div.active-todos ul.content-todo-list")
      list.append(html)



$(window).load ->
  $("form.todo-new").live "ajax:beforeSend", (event,xhr,status) ->
    OUT.todos.createFakeTodo(this)
    $(event.target).find('input[type="text"]').val('').select()

  $("div.todo-checkbox input").live "change", (event) ->
    $(event.target).parents(".content-item").addClass("pending")
    checked = $(event.target).is(':checked')
    data = {"active": !checked}
    url = $(event.target).data("url")
    $.ajax
      url: url
      data: data
      type: 'post'
      dataType: 'script'

  $("form.todo-new a.cancel").live "click", (event) ->
    container = $(this).parents("div.add-content-item-form")
    container_id = $(container).attr("id")
    link = $('a[data-toggle="content-item-form"]').filter('a[data-target="#'+container_id+'"]')
    $(container).hide()
    $(link).show() if link