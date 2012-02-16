# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('input[data-toggle="theme"]').bind "change", (event) ->
    new_theme = $(this).val()
    new_theme_href = "/assets/themes/#{new_theme}.css?reload=#{Math.random()}"
    theme_stylesheet = $('head link[href^="/assets/themes/"]')
    theme_stylesheet.attr("href", new_theme_href)
