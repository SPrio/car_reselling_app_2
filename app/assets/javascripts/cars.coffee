# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  models = $('#car_model').html()
  console.log("model is ",models,"\n")
  $('#car_brand').change ->
    brand = $('#car_brand :selected').text()
    console.log("brand is ",brand,"\n")
    options=$(models).filter("optgroup[label='#{brand}']").html()
    console.log("option is ", options,"\n")
    if options
      $('#car_model').html(options)
    else
      $('#car_model').empty()