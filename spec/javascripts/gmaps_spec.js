//= require jquery
//= require jquery_ujs
//= require gmaps

describe("restTable", function(){
	beforeEach(function(){
		spyOn(google, "Maps");
		spyOn(google.maps, "LatLng");
		spyOn(google.maps, "Map");
		spyOn(google.maps, "Geocoder");
		spyOn(google.maps, "GeocoderStatus");
		spyOn(google.maps, "MapTypeId");
		spyOn(google.maps, "Marker");
		rTable = new restTable('.restaurant_list');
	});

	it("should have the correct selector", function(){
		expect(rTable.el.selector).toBe('.restaurant_list');
	});
});

describe("Card", function(){
	beforeEach(function(){
		spyOn(google, "Maps");
		spyOn(google.maps, "LatLng");
		spyOn(google.maps, "Map");
		spyOn(google.maps, "Geocoder");
		spyOn(google.maps, "GeocoderStatus");
		spyOn(google.maps, "MapTypeId");
		spyOn(google.maps, "Marker");
		rTable = new restTable('.restaurant_list');
		card = new Card('card_0', 'pizza');
	});

	it("should be added to table's list upon init", function(){
		
		rTable.initialize();
		console.log(rTable);
		expect restTable.cards[0].toBe(card);
	});
});