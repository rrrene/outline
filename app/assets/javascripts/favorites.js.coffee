# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

OUT.favorites =
  states: {}
  toggle: (resource_type, resource_id, initial_value) ->
    console.log "toggle", arguments
    key = resource_type + '#' + resource_id
    states = OUT.favorites.states
    if !states[key]?
      states[key] = initial_value
    states[key] = !states[key]
    $.ajax
      type: 'POST'
      url: "/favorites/set"
      dataType: "script"
      data:
        favorite:
          resource_type: resource_type
          resource_id: resource_id
        active: states[key]
    states[key]


$(window).load ->

  handler = (selector) ->
    $.ajax self.location.href + '.js?update_sidebar=true'

  OUT.registerHandler OUT.HANDLER_WILDCARD, "favorite", handler

  $('a[data-toggle="favorite"], button[data-toggle="favorite"]').live "click", (event) ->
    console.log $(this), $(this).context.tagName

    type = $(this).data("resource-type")
    id = $(this).data("resource-id")
    initial_value = $(this).data("initial-value")
    now_active = OUT.favorites.toggle(type, id, initial_value)

    # change icon + title
    klass = if now_active then "icon-no-favorite" else "icon-favorite"
    title_key = if now_active then "title-active" else "title-inactive"
    title = $(this).data(title_key)
    $(this).html "<i class=#{klass}></i> #{title}"

    false
