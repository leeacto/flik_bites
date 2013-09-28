// Shorthand for $(document).ready();
$(document).on("page:load", function(){
 
  $("#next_frame").click(function(event) {
    event.preventDefault();
    var right_val = parseInt($(".frames > li").css("right").replace(/px/,''));
    console.log(right_val);
    if (right_val > 2000) {
      $(".frames > li").animate({"right": "0px"}, "fast");
    } else {
      $(".frames > li").animate({"right": "+=300px"}, "fast");
    }
  });


  $("#previous_frame").click(function(event) {
    event.preventDefault();

    var right_val = parseInt($(".frames > li").css("right").replace(/px/,''));
    console.log(right_val);
    if (right_val < 1) {
      $(".frames > li").animate({"right": "600px"}, "fast");
    } else {
      $(".frames > li").animate({"right": "-=300px"}, "fast");
    }
  });
 
});
