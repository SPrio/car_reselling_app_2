// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs

//= require moment
//= require tempusdominus-bootstrap-4.js
//= require datetimepicker
//= require_tree .

$(function() {
  $(".alert" ).fadeOut(3000);
  $(".alert-*" ).fadeOut(3000);
});
$('#myModal').on('shown.bs.modal', function () {
  $('#myInput').trigger('focus')
})