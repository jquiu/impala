$(document).off('page:load').on('ready page:load', ->
	$('.date').datepicker format: 'yyyy/mm/dd'

	$('#offer_volumen').keypress (e) ->
	  if e.which != 8 and e.which != 0 and (e.which < 48 or e.which > 57)
	    $('#errmsg').html('Solo Numeros').show().fadeOut 'slow'
	    return false
	  return

	$('#offer_price').keypress (e) ->
	  if e.which != 8 and e.which != 0 and (e.which < 48 or e.which > 57)
	    $('#errmsg1').html('Solo Numeros').show().fadeOut 'slow'
	    return false
	  return
)
