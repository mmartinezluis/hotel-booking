// $('input[name="dates"]').daterangepicker();

$(function(){
    $('[data-behavior=daterangepicker]').daterangepicker({
      locale: { format: 'MM/DD/YYYY'},
      locale: { cancelLabel: 'Clear'},
      minDate: moment(),
      endDate: moment().add(1, 'days'),
      autoApply: false
    });
  
    $('[data-behavior=daterangepicker]').on('cancel.daterangepicker', function(){
      $(this).val(' ');   
    });
  });


// Code for applciation.js

//= require bootstrap-datepicker
//= require jquery
//= require moment
//= require daterangepicker