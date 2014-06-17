$ ->
  $("#quantity").keyup (e) ->
    if e.keyCode == 13
      $(@).parent('form').submit()
