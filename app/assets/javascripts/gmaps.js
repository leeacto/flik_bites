// google.maps.event.addDomListener(window, 'load', initialize);

var geocoder;
var map;
var dbc;

function onItemClick(event, pin) { 
  // Create content
  var contentString = pin.data
  // Replace our Info Window's content and position 
  infowindow.setContent(contentString); 
  infowindow.setPosition(pin.position); 
  infowindow.open(map, pin) 
} 

function initialize() {
  geocoder = new google.maps.Geocoder();
  var dbc = new google.maps.LatLng(41.88991, -87.63766);
  

  var mapOptions = {
    zoom: 16,
    center: dbc,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  
  var image = {
    url: './images/dbc.png'
  }

  var marker = new google.maps.Marker({
    icon: image,
    position: dbc,
    map: map,
    data: 'DBC!'
  });

  google.maps.event.addListener(marker, 'click', function() { 
    map.setCenter(new google.maps.LatLng(marker.position.lat(), marker.position.lng())); 
    map.setZoom(16); 
    onItemClick(event, marker); 
  }); 
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
  initialize();

  var subway = new google.maps.Marker({
    icon: './images/no_eat.png',
    position: new google.maps.LatLng(41.88996, -87.63679),
    map: map,
    data: "You Gave Up!"
  });
  google.maps.event.addListener(subway, 'click', function() { 
    map.setCenter(new google.maps.LatLng(subway.position.lat(), subway.position.lng())); 
    map.setZoom(16); 
    onItemClick(event, subway); 
  }); 

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

  $('select').on('change', function(){
    initialize();
    $.ajax({
      url: '/assumption',
      method: 'get',
      data: $(this).serialize(),
      dataType: 'json'
    }).done(function(restaurant) {
      codeAddress(restaurant.address, restaurant, "no_eat.png");
    });
  });
});
