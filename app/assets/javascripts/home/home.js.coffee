$(document).on 'ready page:load', ->
  $("#bgvid").bind "inview", (event, visible) ->
  	if (visible == true)
  		$('#bgvid').get(0).play()
  	else
  		$('#bgvid').get(0).stop()

