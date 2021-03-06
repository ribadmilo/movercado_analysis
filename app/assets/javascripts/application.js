// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//=require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require_tree .
//= require jquery-ui


$(function() {


	//Set datepicker
	$("#date").datepicker({
		showWeek: true,
      	firstDay: 1,
      	dateFormat: 'dd-mm-yy'
	});

	$('#submit_form').click(function(){
		$('#form_nweek').submit();
	});

	$('#form_nweek').submit(function(event){
		event.preventDefault();
		event.stopPropagation();
		var form_data = $(this);
		$.ajax({
			url: form_data.attr('action'),
			type: form_data.attr('method'),
			dataType: "json",
			data:form_data.serialize(),
			complete: function(){
				
			},
			success: function(data, textStatus, xhr){
				$('#sweek').html("Selected week is " + data.current_week);
				$('#tten').empty();
				$('#tten').append('<tbody><th>ID</th><th>#</th><th>FIRST</th><th>LAST</th></tbody>');
				$.each( data.activistas, function( key, value ) {
  					$('#tten').append('<tr><td>'+key+'</td><td> '+value[0]+'</td><td>'+value[1]+'</td><td>'+value[2]+'</td></tr>'); 
				});
    			top10_css();
			},
			error: function(xhr, ajaxOptions, thrownError){
			},
		});

	});
});

function top10_css(){
	jQuery('#tten th').css('width','50px');
	jQuery('#tten th').css('border','2px solid black');
    jQuery('#tten td').css('text-align','center');
    jQuery('#tten td').css('width','150px');
    jQuery('#tten td').css('border','1px solid black');

}

$(document).ready(function(){
    jQuery('#cweek span').css('color','red');
    jQuery('#oweek').css('display', 'inline-block');
	top10_css();

  	jQuery('#submit_form').mouseenter(function(){
  		jQuery(this).css('color', 'red');
  	});

  	jQuery('#submit_form').mouseleave(function(){
  		jQuery(this).css('color', 'black');
  	});

  	jQuery('#submit_form').click(function(){
  		jQuery(this).css('color', 'blue');
  	});
});
