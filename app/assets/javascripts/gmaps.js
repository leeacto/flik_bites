var restTable = function(el) {
  this.el = $(el);
  this.cards = [];
};

restTable.prototype.initialize = function(){
  var self = this;
  $('.card').each(function(){
    var urlPrep = $(this).find(".card_url")[0].innerHTML.replace("<a href",'');
    this.url = urlPrep.substring(3,urlPrep.indexOf("/dishes"));
    var card = new Card(this.id, this.url);
    self.cards.push(card);
  });
}

var Card = function(el, url) {
  this.el = $("#"+el);
  this.url = url;
  var self = this;
  this.geocoder = new google.maps.Geocoder();

  $('body').on('click', '.front',function(event) {
    event.stopPropagation();
    $(event.target).closest('.card').addClass('active');
    self.el.find(".gmap").removeClass('hidden');
    if(self.el.find("img").length === 1 && self.el.find(".gmap").length > 0 )
    {
      self.addMap();
    }
  });

  $('body').on('click', '.back',function(event) {
    event.stopPropagation();
    $(event.target).closest('.card').removeClass('active');
    self.el.find(".gmap").addClass('hidden');
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
  
  $.ajax({
    url: "/"+this.url+"/coords",
    method: 'get',
    data: this.url,
    dataType: 'json'
  }).done(function(coordsBack) {
    if (coordsBack.latitude != null) {
      lat = coordsBack.latitude;
      lon = coordsBack.longitude;
      var coords = new google.maps.LatLng(lat,lon);
      var mapOptions = {
        zoom: 11,
        center: coords,
        disableDefaultUI: true,
        zoomControl: true,
        scaleControl: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      var gmap_url = "http://maps.googleapis.com/maps/api/staticmap?center=" + lat + "," + lon + "&zoom=13&size=129x158&maptype=roadmap&markers=color:red%7C" + lat + "," + lon + "&sensor=false";
      var gmap_img = "<a href='http://maps.google.com/?q=" + coordsBack.gsearch + "' target='_blank'><img src='" + gmap_url + "'></a>"
      
      $("#map-canvas-"+mapNum).html("");
      $("#map-canvas-"+mapNum).append(gmap_img);
      $("#map-canvas-"+mapNum).on('click', function(event) {
        event.stopPropagation();
      });
    }
    else {
      self.geocoder.geocode( { 'address': coordsBack.address}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
          lat = results[0].geometry.location.lat();
          lon = results[0].geometry.location.lng();

          pkg = { 
            lat:  lat,
            lon:  lon,
            url:  self.url
          };

          $.ajax({
            url: "/restaurants/setcoords",
            method: 'POST',
            data: pkg
          });
          var coords = new google.maps.LatLng(lat,lon);
          var mapOptions = {
            zoom: 11,
            center: coords,
            disableDefaultUI: true,
            zoomControl: true,
            scaleControl: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          }
          var gmap_url = "http://maps.googleapis.com/maps/api/staticmap?center=" + lat + "," + lon + "&zoom=13&size=129x158&maptype=roadmap&markers=color:red%7C" + lat + "," + lon + "&sensor=false";
          var gmap_img = "<a href='http://maps.google.com/?q=" + coordsBack.gsearch + "' target='_blank'><img src='" + gmap_url + "'></a>"
          $("#map-canvas-"+mapNum).html("");
          $("#map-canvas-"+mapNum).append(gmap_img);
          $("#map-canvas-"+mapNum).on('click', function(event) {
            event.stopPropagation();
          });
        }
      });
    }
  });
};

function codeAddress(srchString) {
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': srchString.address}, function(results, status) {
    
    if (status === google.maps.GeocoderStatus.OK) {
      var lat = results[0].geometry.location.lat();
      var lng = results[0].geometry.location.lng();
      
      pkg = { 
            lat:  lat,
            lon:  lng,
            id:  srchString.id
          };
      $.ajax({
        url: '/restaurants/setcoords',
        method: 'POST',
        data: pkg
      });
    }
  });
}

function setup() {
  var rTable = new restTable('.restaurant_list');
  rTable.initialize();
  
  $('#new_restaurant').on('submit', function(event){
    event.preventDefault();
    $.ajax({
      url: '/restaurants/create',
      method: 'post',
      data: $(this).serialize(),
      dataType: 'json'
    }).done(function(addr){
      codeAddress(addr);
    });
  });
}

$(document).on('ready', setup);
$(document).on('page:load', setup);