// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require jquery.countdown
//= require jquery.countdown-es
//= require_tree .



function validateForm() {
    var quantity = document.forms["offer_user"]["offer_user[quantity]"].value;
    var price = document.forms["offer_user"]["offer_user[price]"].value;
    if (quantity == null || quantity == "") {
        alert("Los campos no deben estar vacios");
        return false;
    }
    if (price == null || price == "") {
        alert("Los campos no deben estar vacios");
        return false;
    }
}
