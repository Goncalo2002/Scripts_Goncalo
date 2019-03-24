
$(document).ready(function(){

 window.addEventListener( 'message', function( event ) {
        var item = event.data;

        if ( item.showPlayerMenu == true ) {
	$('body').css('background-color','transparent');

$('.container-fluid').css('display','block');
} else if ( item.showPlayerMenu == false ) { // Hide the menu

$('.container-fluid').css('display','none');
$('body').css('background-color','transparent important!');
	$("body").css("background-image","none");

        }
    } );

    $("#recruta").click(function(){
        $.post('http://vrp_armasgnr/recruta', JSON.stringify({}));2

    });
	
	$("#guarda").click(function(){
        $.post('http://vrp_armasgnr/guarda', JSON.stringify({}));2

    });
	
	$("#cabo").click(function(){
        $.post('http://vrp_armasgnr/cabo', JSON.stringify({}));2

    });
	
	$("#coronel").click(function(){
        $.post('http://vrp_armasgnr/coronel', JSON.stringify({}));2

    });
	
	$("#major").click(function(){
        $.post('http://vrp_armasgnr/major', JSON.stringify({}));2

    });
	
	$("#tenente").click(function(){
        $.post('http://vrp_armasgnr/tenente', JSON.stringify({}));2

    });
	
    $("#closebtn").click(function(){
        $.post('http://vrp_armasgnr/closeButton', JSON.stringify({}));2

    });
	
	

})
