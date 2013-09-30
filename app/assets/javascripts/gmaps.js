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
  console.log(this.el.closest('.outer'));
  
  this.el.find('.side').on('click', function(event) {
    event.stopPropagation();
    console.log('click');
    $(event.target).closest('.card').toggleClass('active');
    self.addMap();
    self.el.find(".gmap").toggleClass('hidden');
  });

  this.el.find('a').on('click', function(event) {
      event.stopPropagation();
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
    $("#map-canvas-"+mapNum).on('click', function(event) {
      event.stopPropagation();
    });
  });
};

function codeAddress(srchString) {
  var lat;
  var lng;
  var geocoder = new google.maps.Geocoder();

  geocoder.geocode( { 'address': srchString}, function(results, status) {
    
    if (status === google.maps.GeocoderStatus.OK) {
      var lat = results[0].geometry.location.nb;
      var lng = results[0].geometry.location.ob;
      pkg = { 
        lat:  lat,
        lon:  lng
      };
      return pkg;
    }
  });
  
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

    // $.ajax({
    //   url: '/restaurants/create',
    //   method: 'post',
    //   data: $(this).serialize(),
    //   dataType: 'json'
    // }).done( function(rest_id){
      
    // });

});
