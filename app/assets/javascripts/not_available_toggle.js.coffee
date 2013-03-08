$ ->

  $toggle_link = $('a#instant-toggle')
  $toggle_link.find('.text').text $toggle_link.data('text')

  $toggle_link.show()

  $toggle_link.click ->
    only_instant_button_text = 'ALL'

    $('.movie.not-available').toggle()
    button_text = if $('.not-available').is(':visible') then only_instant_button_text else $toggle_link.data('text')
    $toggle_link.find('.text').text(button_text)
    return false
