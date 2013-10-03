var favoriteOn = function() {
  $('.favorite_on').click(function(e) {
    e.preventDefault();
    console.log("clicked on");
    $(this).children('img').first().attr('src', '/assets/empty_star.png');
    var url = $(this).attr('href');

    $.post(url,function(){});  
  });
};


var favoriteOff = function() {
  $('.favorite_off').click(function(e) {
    e.preventDefault();
    console.log("clicked off");
    $(this).children('img').first().attr('src', '/assets/full_star.png');    
    var url = $(this).attr('href');
    $.post(url,function(){});
  });  
};

$(document).ready(favoriteOn);
$(document).ready(favoriteOff);

$(document).on('page:load', favoriteOn);
$(document).on('page:load', favoriteOff);
