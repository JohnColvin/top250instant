$ ->
  $("a.sorting").click ->
    $("a.sorting").removeClass("sort-selected")
    $(this).addClass("sort-selected")