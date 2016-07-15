# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  pay_form = $("#pay2go_form")
  if pay_form.length > 0
    pay_form.submit()
