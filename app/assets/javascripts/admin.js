// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function() {
  $('#datetimepicker4').datetimepicker({
    format: 'MMMM D, YYYY h:mm A',
    icons: {
      up: 'fas fa-arrow-up',
      down: 'fas fa-arrow-down',
      previous: 'fas fa-chevron-left',
      next: 'fas fa-chevron-right',
      close: 'fas fa-times'
    },
    buttons: {showClose: true }
  });
