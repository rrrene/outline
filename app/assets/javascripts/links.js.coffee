# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?


OUT.links =
  thumbnailizeVideoLinks: ->
    youtube_thumb_template = '''
        <a href="http://youtube.com/watch?v=%{video_id}" data-convert-into="youtube_embed_player" data-video-id="%{video_id}">
          <img src="http://img.youtube.com/vi/%{video_id}/2.jpg" width="120" height="90">
        </a>
        '''
    youtube_embed_template = '<object width="640" height="480" data="http://www.youtube.com/v/%{video_id}?autoplay=1" type="application/x-shockwave-flash"><param name="src" value="http://www.youtube.com/v/%{video_id}?autoplay=1" /></object>'

    content_items =

      $('.content-item-link').each ->
        content_item = $(this)
        insert_link_here = content_item.find("div.thumb")
        content_item.find('small.href a[href*="youtube.com"]').each ->
          link = $(this)
          href = link.attr('href')
          href.match /watch?(\S+)/
          query = RegExp.$1
          matched = query.match /[\?\&]v=([^&]+)/
          if matched
            video_id = matched[1]
            insert_link_here.html youtube_thumb_template.replace(/%{video_id}/g, video_id)

    $('a[data-convert-into="youtube_embed_player"]').live "click", (event) ->
      video_id = $(this).data("video-id")
      $(this).replaceWith youtube_embed_template.replace(/%{video_id}/g, video_id)
      false

$ ->
  OUT.links.thumbnailizeVideoLinks()
  OUT.contentItems.highlightQueryIn(".content-items .content-item-link .content-item-body")