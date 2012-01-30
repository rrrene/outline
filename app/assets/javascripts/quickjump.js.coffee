# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

class OUT.QuickJump
  KEY_UP: 38
  KEY_DOWN: 40
  KEY_ENTER: 13
  KEY_ESC: 27
  MAX_RESULTS: 8

  constructor: (selector) ->
    @selector = selector
    @active_result = null

    $(selector).bind "hidden", ->
      $(selector+" input").blur()

    self = this
    $(selector+" input[type=text]").bind "keydown", (event) ->
      val = self.keydown(event)
      if val == false
        event.preventDefault()
        event.stopPropagation()
      val
    .bind "keyup", (event) ->
      val = self.keyup(event)
      if val == false
        event.preventDefault()
        event.stopPropagation()
      val

    $('body').bind "keypress", (event) ->
      console.log event.target, this
      if event.target == this
        char = String.fromCharCode(event.charCode)
        if char == "t" || char == "p"
          event.preventDefault()
          $(selector).modal("show")
  
  keydown: (event) ->
    if event.keyCode == @KEY_ENTER
      result = this.getActiveResult()
      if result?
        window.location.href = result.attr('href')
      false
    else if event.keyCode == @KEY_UP
      this.moveSelection(-1)
      false
    else if event.keyCode == @KEY_DOWN
      this.moveSelection(+1)
      false
  
  keyup: (event) ->
    console.log "keyup", event.keyCode, event.target.value

    query = event.target.value
    if query.length > 2
      url = $(event.target).data('url')
      data = {}
      data[$(event.target).attr("name")] = query
      self = this

      console.log "sending query:", data, "url:", url

      $.ajax
        url: url
        data: data
        type: 'get'
        dataType: 'script'
        complete: (request) ->
          self.requestComplete(request)
  
  moveSelection: (modifier) ->
    max_result = Math.min(@results.length, @MAX_RESULTS)
    @active_result += modifier
    @active_result = max_result-1 if @active_result < 0
    @active_result = 0 if @active_result > max_result-1
    this.markActiveResult()

  requestComplete: (request) ->
    @results = eval(request.responseText)
    this.renderResults(request)
    @active_result = 0
    this.markActiveResult();

  renderResults: (request) ->
    template = '<a class=result href="/pages/%{id}"><div class=title>%{title}</div><div class=path>%{path}</div></a>'
    out = ""
    for result in @results[0...@MAX_RESULTS-1]
      out += template.toString().replace("%{title}", result.title).replace("%{path}", result.id).replace("%{id}", result.id)

    $(@selector+" .results").html(out)

  markActiveResult: ->
    if @active_result?
      $(@selector+" .result").removeClass "active"
      this.getActiveResult().addClass "active"
  
  getActiveResult: ->
    if @active_result?
      all = $(@selector+" .result")
      $(all[@active_result])

$ ->
  OUT.quickjump = new OUT.QuickJump "#quick-jump-modal"