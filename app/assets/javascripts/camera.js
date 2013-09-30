$(document).ready(function() {
    (function () {
        var takePicture = document.querySelector("#take-picture"),
            showPicture = document.querySelector("#show-picture");
            
            if (takePicture && showPicture) {
            takePicture.onchange = function (event) {
                var files = event.target.files,
                    file;
                if (files && files.length > 0) {
                    file = files[0];
                    try {
                        var URL = window.URL || window.webkitURL;

                        var imgURL = URL.createObjectURL(file);

                        showPicture.src = imgURL;

                        URL.revokeObjectURL(imgURL);
                    }
                    catch (e) {
                        try {
                            var fileReader = new FileReader();
                            fileReader.onload = function (event) {
                                showPicture.src = event.target.result;
                            };
                            fileReader.readAsDataURL(file);
                        }
                        catch (e) {

                            var error = document.querySelector("#error");
                            if (error) {
                                error.innerHTML = "createObjectURL or FileReader are not working";
                            }
                        }
                    }
                }
            };
        }
    })();

   $("#take-picture").change(function () 
   { 
     var filesize = ($("#take-picture")[0].files[0].size / 1024); 
     if (filesize / 1024 > 1) 
     { 
        if (((filesize / 1024) / 1024) > 1) 
        { 
            filesize = (Math.round(((filesize / 1024) / 1024) * 100) / 100);
            $("#filesize").html( filesize + "Gb"); 
        }
        else
        { 
            filesize = (Math.round((filesize / 1024) * 100) / 100)
            $("#filesize").html( filesize + "Mb"); 
        } 
     } 
     else 
     {
        filesize = (Math.round(filesize * 100) / 100)
        $("#filesize").html( filesize  + "kb"); 
     }    
  }); 

});




