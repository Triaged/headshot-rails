$ ->
  #$('.datepicker').datetimepicker(pickTime: false)    

  $("#import_users_form input[type='checkbox']").change ->
    if @checked  
      $(this).siblings(".import-label").text("add contact")
    else
      $(this).siblings(".import-label").text("skip contact")

  $("#import_users_form").validate
    debug: true
    rules:
      import:
        required: (element) ->
          boxes = $(".import-checkbox")
          console.log boxes.filter(":checked").length
          return true  if boxes.filter(":checked").length is 0
          false

        minlength: 1

    messages:
      import: "Please select at least two types of spam."


  $("#import-contacts-button").click ->
    console.log("clicked")
    console.log $("#import_users_form").valid()
      