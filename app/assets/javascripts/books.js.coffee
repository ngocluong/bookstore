# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('body').on 'shown.bs.modal', '#add-review-modal', (event) ->
    $('#add-review-modal .raty').raty()
  $('body').on 'change', 'select#per_page', (event) ->
    $(@).parent('form').submit()
  $(".show-raty").raty (
    score: -> $(this).attr "data-score",
    readOnly: -> true
  )
