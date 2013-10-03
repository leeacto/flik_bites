$( document ).ready(function() {
 
    $("#close_button").click(function(event) {
      $('#tab').animate({
        height: ".1%"
      }, 500, function() {
        $('#review_form').css("opacity", "0");
        $('#review_show').css("opacity", "0");
        $('#review_form').css("display", "none");
        $('#review_show').css("display", "none")
      });
    });
    
    $("#review_button").click(function(event) {
      $('#tab').animate({
        height: "100%"
      }, 500, function() {
        $('#review_form').css("opacity", "1");
        $('#review_show').css("opacity", "1");
        $('#review_form').css("display", "block");
        $('#review_show').css("display", "block")
      });
    })
});