var restTable = function() {
  this.cards = []
  this.initialize();
};


restTable.prototype.initialize = function(){
  var self = this;
  $('.card').each(function(){
    var urlPrep = $(this).find("#rest_dish_link")[0].innerHTML.replace("<a href",'');
    var url = urlPrep.substring(3,urlPrep.indexOf("/dishes"));
    var card = new Card(this.id, this.url);
    self.cards.push(card);
  });
}

var Card = function(el, url) {
  this.el = $(el);
  this.url = url;
  this.getCoords();

  var dbc = new google.maps.LatLng(41.88991, -87.63766);
  var mapOptions = {
    zoom: 16,
    center: dbc,
    disableDefaultUI: true,
    zoomControl: true,
    scaleControl: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var mapNum = el.replace('card-','');
  var gmap = new google.maps.Map(document.getElementById("map-canvas-"+mapNum), mapOptions);
};

Card.prototype.getCoords = function() {
  var lat;
  var lng;

  $.ajax({
    url: "/"+this.url+"/coords",
    method: 'get',
    data: this.url,
    dataType: 'json'
  }).done(function(coords) {

  });

}

google.maps.Map.prototype.placeMarker = function() {
  alert('hi');
}

function codeAddress(address, restaurant) {
  var lat;
  var lng;
  var geocoder = new google.maps.Geocoder();
  if (restaurant.lat !== null) {
    lat = restaurant.lat;
    lng = restaurant.lon;
  }
  else {
    geocoder.geocode( { 'address': address}, function(results, status) {
      
      if (status === google.maps.GeocoderStatus.OK) {
        lat = results[0].geometry.location.ob;
        lng = results[0].geometry.location.pb;
        pkg = { 
          lat:  lat,
          lon:  lng,
          id:  restaurant.id
        };

        $.ajax({
          url: '/coords',
          data: pkg,
          method: 'post'
        });
      }
    });
  }
  setMarker(lat, lng);
}

function setMarker(lat, lon) {
  var latLng = new google.maps.LatLng(lat, lon);
  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    data: html
  });
}



$(document).ready(function() {
  // initialize();
  var cards = new restTable();

  $('#search_form').on('submit', function(event) {
    event.preventDefault();
    
    $.ajax({
      url: '/restaurants',
      method: 'get',
      data: $(this).serialize(),
      dataType: 'json'
    }).done( function(restaurants){
      for (var i in restaurants) {
        codeAddress(restaurants[i].address + " Chicago", restaurants[i], "eat.png");
      }
    });
  });

});
