$ ->
  $("body > .topbar").scrollspy()
$ ->
  $(".tabs").tab()
$ ->
  $("a[rel=twipsy]").tooltip live: true
$ ->
  $("a[rel=popover]").popover offset: 10
$ ->
  $('.dropdown-toggle').dropdown()
$ ->
  $(".alert-message").alert()
$ ->
  $(".modal").modal().modal("hide").bind 'shown', ->
    $(this).find('input[type=text], textarea').first().select()
  .bind 'hide', ->
    $(this).find('input[type=text], textarea').blur()
  