$ ->
  $("a").click ->
    console.log 'click sort'
    $("a.sorting").removeClass("sort-selected")
    $(this).addClass("sort-selected")