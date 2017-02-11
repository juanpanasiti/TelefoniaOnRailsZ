// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require material
//= require material/mdlComponentHandler
//= require material/rAF
//= require material/button
//= require material/checkbox
//= require material/data-table
//= require material/icon-toggle
//= require material/layout
//= require material/menu
//= require material/progress
//= require material/radio
//= require material/ripple
//= require material/slider
//= require material/snackbar
//= require material/spinner
//= require material/switch
//= require material/tabs
//= require material/textfield
//= require material/tooltip
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
document.addEventListener('turbolinks:load', function() {
  componentHandler.upgradeDom();
});
