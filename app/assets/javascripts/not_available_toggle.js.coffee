$ ->
  $('#instant-toggle a').show()

  $('#instant-toggle a').click ->
    $('.movie .not-available').toggle()
    button_text = if $('.not-available').is(':visible') then 'Only show movies available on Netflix instant streaming' else 'Show entire IMDB top 250'
    console.log button_text
    $(this).html(button_text)
    return false