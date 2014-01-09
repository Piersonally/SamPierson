// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery.datetimepicker
//= require ./Sam
//= require_tree ./Sam
//= require_tree .

$(document).on('page:change', function() {
  $('input[type=datetime]').datetimepicker({
    allowBlank: true
  });

  $('[data-activate-datepicker]').each(function() {
    var dateTimePickerSelector = $(this).data('activate-datepicker');
    $(this).click(function() {
      $(dateTimePickerSelector).datetimepicker('show');
    });
  })
});
