// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require out/initializers
//= require_tree .

if (window.OUT == null) window.OUT = {};

OUT.selectFirstInput = function(ele) {
  ele || (ele = window)
  $(ele).find("input[type=text], textarea").first().select();
}

/*
OUT.handlers = {
  listSorted: function(event, ui) {
    console.log("handlers.listSorted", $(this));
    var url = $(this).attr("data-sort-url");
    var data = $(this).sortable('serialize');
    $.ajax({
      url: url,
      data: data,
      type: 'post',
      dataType: 'script',
      complete: function(request) {}
    })
  }, 
  dropOnContentItem: function (event, ui) {
    var draggedId = ui.draggable[0].id;
    var droppedId = $(this).attr("id");
    console.log("handlers.dropOnContentItem", event, ui);
    console.log(draggedId, " -> ", droppedId);
  }
};
*/

$(function(){
  OUT.contentItems.createSortables();
  OUT.contentItems.createDroppables();
  OUT.initializers.selectFirstInput();
});
