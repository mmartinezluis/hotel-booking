
/* globals daterangepicker, $ */
"use strict";

$(function(){
  $('[data-behavior=daterangepicker]').daterangepicker({
    locale: { format: 'DD/MM/YYYY'},
    cancelLabel: 'Clear'
  });

  $('[data-behavior=daterangepicker]').on('cancel.daterangepicker', function(){
    $(this).val(' ');
  });

});