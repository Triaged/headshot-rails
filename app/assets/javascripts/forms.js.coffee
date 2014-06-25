$ ->
  #$('.datepicker').datetimepicker(pickTime: false)    

  $("#import_users_form input[type='checkbox']").change ->
  	if @checked  
  		$(this).siblings(".import-label").text("add contact")
  	else
  		$(this).siblings(".import-label").text("skip contact")
  		