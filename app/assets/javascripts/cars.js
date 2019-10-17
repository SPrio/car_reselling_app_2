$(document).on("change", '#car_brand', function() {
  var models;
  models = $('#car_model').html();
  var brand, options;
  brand = $('#car_brand :selected').text();
  console.log("brand is ", brand, "\n");
  options = $(models).filter("optgroup[label='" + brand + "']").html();
  console.log("option is ", options, "\n");
  if (options) {
    return $('#car_model').html(options);
  } else {
    return $('#car_model').empty();
  }
});