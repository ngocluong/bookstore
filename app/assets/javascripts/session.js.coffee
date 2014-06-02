$ ->
  $('body').on 'ajax:complete', 'form#new_user', (response, xhr) ->
    if xhr.status == 200
      eval(xhr.responseText)
    else
      $(@).prepend(xhr.responseText)

