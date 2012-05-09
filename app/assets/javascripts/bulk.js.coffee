# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.OUT = {} unless window.OUT?

OUT.bulk = 
  initialize: ->
    if $('#bulk_collection').length > 0
      OUT.bulk.allCheckboxes().bind "change", ->
        OUT.bulk.markSelected()
      OUT.bulk.markSelected()

    $("#move-to-new-project-modal input.btn-primary").bind "click", (event) ->
      console.log "move to new project"
      OUT.bulk.moveToNewProject(this);
      event.preventDefault();
      return false

    $("#add-tags-modal input.btn-primary").bind "click", (event) ->
      OUT.bulk.addTags(this);
      event.preventDefault();
      return false

    $("select#move_to_project_id").bind "change", ->
      if $(this).val() == "-1"
        OUT.bulk.showOptionsHelper("#move-to-new-project-modal")
      else
        if $(this).val() != ""
          OUT.bulk.execute "move_to_project", this


  addTags: (ele) ->
    $('#bulk_add_tags_tag_list').val $("#bulk_tag_list").val()
    OUT.bulk.execute "add_tags", ele
  allCheckboxes: ->
    $("#bulk_collection .checkbox input")
  execute: (action, ele, confirm_msg) ->
    OUT.bulk.setAction action
    if !confirm_msg || confirm(confirm_msg)
      # OUT.loadingElement(ele);
      jQuery('#bulk_form').submit()
  selectAll: ->
    OUT.bulk.allCheckboxes().attr("checked", "checked")
    OUT.bulk.markSelected();
  selectNone: ->
    OUT.bulk.allCheckboxes().attr("checked", null)
    OUT.bulk.markSelected();
  setAction: (action) ->
    jQuery('#bulk_action').val(action);
  markSelected: ->
    all_rows = OUT.bulk.allCheckboxes().parents(".entry")
    console.log "all_rows:", all_rows
    all_rows.removeClass("active")
    checked_rows = all_rows.find("input:checked").parents(".entry")
    console.log "checked_rows:", checked_rows
    checked_rows.addClass("active")

    if checked_rows.length > 0 
      $("#bulk_collection #no_items_selected").hide()
      $("#bulk_collection #items_selected").show()
    else
      $("#bulk_collection #no_items_selected").show()
      $("#bulk_collection #items_selected").hide()

    if checked_rows.length < all_rows.length
      $("#bulk_collection .select_all").show()
    else
      $("#bulk_collection .select_all").hide()

    if checked_rows.length > 0
      $("#bulk_collection .select_none").show()
    else
      $("#bulk_collection .select_none").hide()



  moveToNewProject: (ele) ->
    $('#bulk_new_project_title').val $("#move_to_new_project_title").val()
    OUT.bulk.execute "move_to_new_project", ele
  showOptionsHelper: (ele) ->
    $(ele).modal("show")
    OUT.selectFirstInput(ele)

$(window).load ->
  OUT.bulk.initialize()