$ -> 
  $('.search-icon').click ->
    $('.toggleable').slideToggle()
    $('#term').focus()
    return false