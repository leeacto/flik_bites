$(document).ready(function() {
  $('.favorite_on').click(function(e) {
    e.preventDefault();
    $(this).children('img').first().attr('src', '/assets/empty_star.png');
    var url = $(this).attr('href');
    $.post(url,function(){});
  });

  $('.favorite_off').click(function(e) {
    e.preventDefault();
    $(this).children('img').first().attr('src', '/assets/full_star.png');    
    var url = $(this).attr('href');
    $.post(url,function(){});
  });
});