
window.OUT = {} unless window.OUT?

OUT.selectFirstInput = (ele) ->
  ele or= window
  $(ele).find("input[type=text], textarea").first().select()


$ ->
  OUT.selectFirstInput()
  
  #
  # Submit a textarea on ctrl+enter
  #
  $("textarea").bind "keydown", (event) ->
    if event.keyCode == 13 && event.ctrlKey
      console.log $(event.target).parents("form").submit()