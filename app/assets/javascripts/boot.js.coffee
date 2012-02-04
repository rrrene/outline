
window.OUT = {} unless window.OUT?

OUT.selectFirstInput = (ele) ->
  ele or= document
  $(ele).find("input[type=text], textarea").first().select()


$ ->
  OUT.selectFirstInput()
  
  #
  # Submit a textarea on ctrl+enter
  #
  $("textarea").bind "keydown", (event) ->
    if event.keyCode == 13 && event.ctrlKey
      $(event.target).parents("form").submit()

  $('[data-submit="form"]').bind "change", (event) ->
    $(event.target).parents("form").submit()