$( document ).ready(function() {

    $( ".trip-insert-radio" ).click(function() {
        $(this).find('.rbtn').attr('checked', 'checked');
    });

    $(".article-gallery").lightGallery();
    $(".article-gallery-thumbs").lightGallery();


    if(!($( ".alerts" ).length)){
        $('#trip-insert-frm').css('height', 0);
    }


    $("#open-frm-insert").click(function(){

        var pannel = $('#trip-insert-frm');

        var defaultHeight = pannel.height();
        pannel.css('height', 'auto');

        var autoHeight = pannel.height();
        if(defaultHeight != ''){
            autoHeight = 0;
        }

        pannel.css('height', defaultHeight);

        pannel.animate({height: autoHeight}, 200);
    });


});

//
// Frm find place (MAPS API)
//

function initGeoEdit() {
    var geocoder = new google.maps.Geocoder();

    //init load
    geocodeAddress(geocoder);

    $('#find_addr').focusout(function() {
        geocodeAddress(geocoder);
    });
}

function geocodeAddress(geocoder) {
    var address = document.getElementById('find_addr').value;
    geocoder.geocode({'address': address}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {

            var htmlcode = "";
            for(var i=0; i<results.length; i++){
                var line = "<div class='formated_adress'><span class='rbtn_adress_span'>";
                line += "<input class=\"rbtn\" type=\"radio\" name=\"stage[adress]\" value=\""+results[i].formatted_address+"\"";

                if(i==0){
                    line += " checked ";
                }

                line += "/></span><span><p>" + results[i].formatted_address+ "<br /><span class='gps_adress'>GPS:" + results[i].geometry.location + "</span></p></span>";
                line += "<div>";
                htmlcode += line;
            }

            $('#finded_adresses').html(htmlcode);
            $('#nb_results').text(results.length+" results")

        } else {

            if(status == 'ZERO_RESULTS'){
                $('#nb_results').text(0+" result")
            }
            else{
                $('#nb_results').text(status);
            }

        }
    });
}

function sliderShowValue(newValue)
{
    document.getElementById("score").innerHTML=newValue;
}