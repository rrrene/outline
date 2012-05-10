# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

OUT.registerHandler OUT.HANDLER_WILDCARD, OUT.HANDLER_WILDCARD, ->
  OUT.activities.reloadActivities()

OUT.activities =
  reloadActivities: ->
    console.log self.location.href
    if self.location.href.match(/activities$/)
      $.ajax self.location.href + '.js'