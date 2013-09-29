var geocoder;

var restTable = function() {
  this.cards = []
  this.initialize();
};

restTable.prototype.initialize = function(){
  var self = this;
  $('.card').each(function(){
    var urlPrep = $(this).find("#rest_dish_link")[0].innerHTML.replace("<a href",'');
    this.url = urlPrep.substring(3,urlPrep.indexOf("/dishes"));
    var card = new Card(this.id, this.url);
    self.cards.push(card);
  });
}

var Card = function(el, url) {
  this.el = $("#"+el);
  this.url = url;
  var self = this;

  this.el.find('.side').on('click', function(event) {
    event.stopPropagation();
    $(event.target).closest('.card').toggleClass('active');
    self.addMap();
    self.el.find(".gmap").toggleClass('hidden');
  });
};

Card.prototype.addMap = function() {
  var lat;
  var lon;
  var el = this.el;
  var url = this.url;
  var self = this;
  var mapNum = el.selector.replace('#card-','');
  console.log(mapNum);
  geocoder = new google.maps.Geocoder();

  $.ajax({
    url: "/"+this.url+"/coords",
    method: 'get',
    data: this.url,
    dataType: 'json'
  }).done(function(coordsBack) {
    if (coordsBack.latitude != "") {
      lat = coordsBack.latitude;
      lon = coordsBack.longitude;
    }
    else {
      geocoder.geocode( { 'address': address}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
          lat = results[0].geometry.location.ob;
          lng = results[0].geometry.location.pb;

          pkg = { 
            lat:  lat,
            lon:  lng,
            url:  self.url
          };

          $.ajax({
            url: '/setcoords',
            data: pkg,
            method: 'post'
          });
        }
      });
    }
      
    var coords = new google.maps.LatLng(lat,lon);
    var mapOptions = {
      zoom: 11,
      center: coords,
      disableDefaultUI: true,
      zoomControl: true,
      scaleControl: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    console.log(coords);
    self.gmap = new google.maps.Map(document.getElementById("map-canvas-"+mapNum), mapOptions);
    self.gmap.setMarker(coords);
  });
};

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
          url:  self.url
        };

        $.ajax({
          url: '/setcoords',
          data: pkg,
          method: 'post'
        });
      }
    });
  }
  setMarker(lat, lng);
}

google.maps.Map.prototype.setMarker = function (coordObj) {
  var self = this;
  var marker = new google.maps.Marker({
    position: coordObj,
    map: self
  });
}



$(document).ready(function() {
  var rTable = new restTable();

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
