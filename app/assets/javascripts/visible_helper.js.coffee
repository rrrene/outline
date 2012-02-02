
OUT.ensureElementIsInViewport = (ele) ->
  window_height = $(window).height()
  scroll_y = $(window).scrollTop()
  ele_y = $(ele).offset().top
  ele_height = $(ele).height()

  y_to_be_visible = ele_y + ele_height
  last_y_visible = scroll_y + window_height
  scroll_to = null
  scroll_to = ele_y if scroll_y > ele_y
  scroll_to = y_to_be_visible - window_height if y_to_be_visible > last_y_visible

  if scroll_to?
    $('html, body').animate
        scrollTop: scroll_to
      , 200
