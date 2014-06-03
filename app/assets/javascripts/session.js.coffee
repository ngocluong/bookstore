$ ->
  $('body').on 'ajax:complete', 'form#new_user', (response, xhr) ->
    if xhr.status == 200
      eval(xhr.responseText)
    else
      $('#new_user .error').html(xhr.responseText)
      $('#new_user #user_password').val('')

  $('body').on 'ajax:complete', 'form#registration', (response, xhr) ->


