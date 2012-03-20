$ ->
  $("div.tabs").tab()
$ ->
  $("a[rel=twipsy]").tooltip live: true
$ ->
  $("a[rel=popover]").popover offset: 10
$ ->
  $('.dropdown-toggle').dropdown()
$ ->
  $(".alert-message").alert()

# Automatically select and deselect text inputs in modals
$ ->
  $("div.modal").modal().modal("hide").bind 'shown', ->
    $(this).find('input[type=text], textarea').first().select()
  .bind 'hide', ->
    $(this).find('input[type=text], textarea').blur()

  $('div.modal a.btn.cancel').bind "click", (event) ->
    $(this).parents('div.modal').modal('hide')
    false