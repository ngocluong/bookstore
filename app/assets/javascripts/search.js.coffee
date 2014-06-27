$ ->
  $('body').on 'click', 'button#search', (event) ->
    $(@).parent('form').submit()
