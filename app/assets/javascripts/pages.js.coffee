# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ -> 
  $('#page_context_id').bind 'change', ->
    new_project_fields = $('#add-to-new-project')
    if $(this).val() == "-1"
      new_project_fields.show()
      OUT.selectFirstInput(new_project_fields)
    else
      new_project_fields.hide()