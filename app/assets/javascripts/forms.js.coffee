$ ->
  $(".datepicker").datepicker
    format: "mm/dd/yyyy"
    todayHighlight: true
    autoclose: true 

  $(".datepicker-noyear").datepicker
    format: "mm/dd"
    todayHighlight: true
    autoclose: true  

  $("#import_users_form input[type='checkbox']").change ->
    if @checked  
      $(this).siblings(".import-label").text("add contact")
    else
      $(this).siblings(".import-label").text("skip contact")

  $("#import-contacts-button").click ->
    unless $("#import_users_form").valid()
      false

  $("#import_users_form").validate(
    ignore: []
    errorClass: "has-error help-block"
    rules:
      "imports":
        required: (element) ->
          boxes = $(".import-checkbox")
          return true  if boxes.filter(":checked").length is 0
          false

        minlength: 1
    messages:
      "imports": "Please select at least one contact."
    errorPlacement: (error, element) ->
      console.log error
      error.appendTo($("#import-form-error"))
  )


  
      