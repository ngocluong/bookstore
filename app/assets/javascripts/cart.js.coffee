$ ->
  $("#quantity").keyup (e) ->
    if e.keyCode == 13
      $(@).parent('form').submit()

  $('body').on 'click', '.proceed-image', (event) ->
    $(@).parents('form').submit()

  handler = StripeCheckout.configure(
    key: "pk_test_hWPuCZ7m1AtIAsa2oVuP6vE7"
    token: (token) ->
      $('input#token').val(token.id)
      $('button#customButton').attr('disabled','disabled')
      $('button#customButton').css('background', 'green')
  )

  # Use the token to create the charge with a server-side script.
  # You can access the token ID with `token.id`
  $('body').on 'click', 'button#customButton', (event) ->
    # Open Checkout with further options
    handler.open
      name: "In Betweener"
    event.preventDefault()

