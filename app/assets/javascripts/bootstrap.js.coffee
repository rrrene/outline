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
  
