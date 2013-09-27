function showStarterTab(){
	$('.starters').removeClass('hidden');
	$('.entrees').addClass('hidden');
	$('.desserts').addClass('hidden');
}

function showEntreeTab(){
	$('.starters').addClass('hidden');
	$('.entrees').removeClass('hidden');
	$('.desserts').addClass('hidden');
}

function showDessertTab(){
	$('.starters').addClass('hidden');
	$('.entrees').addClass('hidden');
	$('.desserts').removeClass('hidden');
}

$(document).ready(function(){
	$('#starters_tab').on('click', function(event){
		event.stopPropagation();
		showStarterTab();
	});

	$('#entrees_tab').on('click', function(event){
		event.stopPropagation();
		showEntreeTab();
	});

	$('#desserts_tab').on('click', function(event){
		event.stopPropagation();
		showDessertTab();
	});
});