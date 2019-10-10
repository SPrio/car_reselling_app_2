// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/

$('#datetimepicker1').datetimepicker({
  format: "YYYY.MM.DD hh:mm A",
  stepping: 15,
  useCurrent: false,
  sideBySide: true,
  icons: {
    up: 'fas fa-arrow-up',
    down: 'fas fa-arrow-down',
    previous: 'fas fa-chevron-left',
    next: 'fas fa-chevron-right',
    close: 'fas fa-times'
  },
  buttons: {showClose: true }
});

$('#datetimepicker').datetimepicker({
  format:'d.m.Y H:i',
  inline:true,
  lang:'ru'
});