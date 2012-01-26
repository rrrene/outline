$ ->
  $("body > .topbar").scrollSpy()
$ ->
  $(".tabs").tabs()
$ ->
  $("a[rel=twipsy]").twipsy live: true
$ ->
  $("a[rel=popover]").popover offset: 10
$ ->
  $(".topbar").dropdown()
$ ->
  $(".alert-message").alert()
$ ->
  domModal = $(".modal").modal(
    backdrop: true
    closeOnEscape: true
  ).bind 'shown', ->
    $(this).find('input[type=text], textarea').first().select()

  $(".open-modal").click ->
    domModal.toggle()  
  
  # When the ENTER key is pressed in a textfield inside a modal, click the primary button
  $(".modal input[type=text]").bind "keypress", (event) ->
    if( event.which == 13 )
      modal = $(this).parents(".modal")
      primary = modal.find("input.primary, a.primary")
      primary.click()
      event.preventDefault();
      return false
