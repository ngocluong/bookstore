# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('body').on 'click', 'a#add-review', (event) ->
    $('div.raty').raty();
  $('body').on 'change', 'select#per_page', (event) ->
    $(@).parent('form').submit()
