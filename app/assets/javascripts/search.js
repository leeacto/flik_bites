var liveSearch = function() {
  $("#search_field").bind("keyup", function() {
    var url = $("#search_form").attr("action")
    var data = $("#search_form").serialize();

    $.get(url, data, function(response){
        console.log(response);
        $("#live-search").html(response);
    });
  });
};

$(document).ready(liveSearch);
$(document).on('page:load', liveSearch);
