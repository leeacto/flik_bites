var restTable = function() {
  this.cards = []

  this.initialize();
};


restTable.prototype.initialize = function(){
  var self = this;
  $('.card').each(function(){
    var card = new Card(this.id);
    console.log(self);
    self.cards.push(card);
  })

}

var Card = function(el) {
  this.el = $(el);
  var geocoder = new google.maps.Geocoder();
  var dbc = new google.maps.LatLng(41.88991, -87.63766);
  var mapOptions = {
    zoom: 16,
    center: dbc,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  console.log(el);
  var mapNum = el.replace('card-','');
  var gmap = new google.maps.Map(document.getElementById("map-canvas-"+mapNum), mapOptions);
};


var geocoder;
var map;

function onItemClick(event, pin) { 
  // Create content
  var contentString = pin.data
  // Replace our Info Window's content and position 
  infowindow.setContent(contentString); 
  infowindow.setPosition(pin.position); 
  infowindow.open(map, pin) 
} 

function initialize() {
  var geocoder = new google.maps.Geocoder();
  var dbc = new google.maps.LatLng(41.88991, -87.63766);
  

  map = new google.maps.Map(document.getElementById('map-canvas-0'), mapOptions);
  
  infowindow = new google.maps.InfoWindow({ maxWidth: 320 }); 
}

function codeAddress(address, restaurant, i_type) {
  var lat;
  var lng;
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

  html = "<b>" + restaurant.name + "</b>" + "  - $" + 
            restaurant.avg_price + "<br>" + 
            restaurant.food_type + "<br><br>" +
            "Votes: " + restaurant.votes + "<a href='/restaurant/" + restaurant.id + "/up'> + </a>" + 
            "<a href='/restaurant/" + restaurant.id + "/down'> - </a><br>" + 
            restaurant.address;
  setMarker(lat, lng, html, i_type);
}

function setMarker(lat, lon, html, i_type) {
  var latLng = new google.maps.LatLng(lat, lon);
  var image = './images/'+i_type
  var marker = new google.maps.Marker({
    icon: image,
    position: latLng,
    map: map,
    data: html
  });
  
  google.maps.event.addListener(marker, 'click', function() { 
    map.setCenter(new google.maps.LatLng(marker.position.lat(), marker.position.lng())); 
    map.setZoom(16); 
    onItemClick(event, marker); 
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
