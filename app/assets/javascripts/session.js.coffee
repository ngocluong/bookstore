$ ->
  $('body').on 'click', '#sign_up', (event) ->
    $('#sign-in-modal').modal('hide')
  $('body').on 'ajax:complete', 'form#new_user', (response, xhr) ->
    if xhr.status == 200
      eval(xhr.responseText)
    else
      $('#new_user .error').html(xhr.responseText)
      $('#new_user #user_password').val('')
