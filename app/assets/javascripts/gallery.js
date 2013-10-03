window.onload = function() {
  var mySwiper = new Swiper('.swiper-container',{
    //Your options here:
    mode:'horizontal',
    loop: false
  });  
};

/*
Or with jQuery/Zepto
*/
$(document).on('page:load', function(){
  var mySwiper = $('.swiper-container').swiper({
    //Your options here:
    mode:'horizontal',
    loop: false

  });
});
