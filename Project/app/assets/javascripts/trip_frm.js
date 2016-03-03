$( document ).ready(function() {

    $( ".trip-insert-radio" ).click(function() {
        $(this).find('.rbtn').attr('checked', 'checked');
    });
});

//
// Frm find place (MAPS API)
//

function initGeo() {
    var geocoder = new google.maps.Geocoder();

    $('#stage_adress').focusout(function() {
        geocodeAddress(geocoder);
    });
}

function geocodeAddress(geocoder) {
    var address = document.getElementById('stage_adress').value;
    geocoder.geocode({'address': address}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
            //resultsMap.setCenter(results[0].geometry.location);
            //var marker = new google.maps.Marker({
            //  map: resultsMap,
            //  position: results[0].geometry.location
            //});

            $('#info_adress').html("<b>" + results[0].formatted_address + "</b><br />GPS : " + results[0].geometry.location );
        } else {
            $('#info_adress').html(status);
        }
    });
}