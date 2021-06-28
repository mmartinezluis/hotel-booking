
// console.log("hello there")

// $('input[name="dates"]').daterangepicker();

// (function(){
//     ('[data-behavior=daterangepicker]').daterangepicker({
//       locale: { format: 'MM/DD/YYYY'},
//       cancelLabel: 'Clear',
//       minDate: moment(),
//       endDate: moment().add(1, 'days'),
//       autoApply: true
//     });
  
//     ('[data-behavior=daterangepicker]').on('cancel.daterangepicker', function(){
//       (this).val(' ');
//     });
//   });



$(function(){
    $('[data-behavior=daterangepicker]').daterangepicker({
      locale: { format: 'MM/DD/YYYY'},
      cancelLabel: 'Clear',
      minDate: moment(),
      endDate: moment().add(1, 'days'),
      autoApply: true
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