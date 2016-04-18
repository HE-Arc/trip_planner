function initGeo() {
    var geocoder = new google.maps.Geocoder();

    $('#find_addr').focusout(function() {
        geocodeAddress(geocoder);
    });

    //initialize maps (trip_map.js)
    initMap();
}


function initMap() {

    var directionsService = new google.maps.DirectionsService;

    var directionsDisplay = new google.maps.DirectionsRenderer(
        {
            suppressMarkers: true
        });


    calculateAndDisplayRoute(directionsService, directionsDisplay, map);
}


function calculateAndDisplayRoute(directionsService, directionsDisplay, map) {

    $.ajax({
        type: 'GET',
        url: '/maptrip/'+$('#trip_id').text(),
        success: function (data, textStatus, jqXHR) {

            var disableUI = false;
            var tripbox = $('#trip-box');
            if(tripbox.length)
            {
                $('#tripName').text(data.trip.title);
                $('#tripUserName').text(data.user.username);
                $('#tripLocation').text(data.trip.country_name.data.name);
                $('#trip-img').attr("src", data.trip.image_url);

                var dateStart = new Date(data.trip.date_start);
                var dateEnd = new Date(data.trip.date_end);

                $('#tripDate').text(dateStart.toLocaleDateString() + " - " + dateEnd.toLocaleDateString());

                $('#tripDiscoverButton').attr("href", "/trips/"+data.trip.id);

                tripbox.css('display', 'block');
                disableUI = true;
            }

            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 6,
                scrollwheel: false,
                center: {lat: parseFloat(data.trip.country_name.data.latitude_dec), lng: parseFloat(data.trip.country_name.data.longitude_dec)},
                disableDefaultUI: disableUI
            });


            directionsDisplay.setMap(map);


            var waypts = [];
            var wayptscpy = [];

            for(var i=0; i<data.stages.length; i++)
            {
                waypts.push({
                    location: data.stages[i].adress,
                    stopover: true
                });

                wayptscpy.push({
                    location: data.stages[i].adress,
                    stopover: true,
                    id: data.stages[i].id,
                    title: data.stages[i].title,
                    date_time: data.stages[i].date_time
                });
            }

            if(waypts.length > 0){

                var orig = null;
                var dest = null;
                if(waypts.length > 1){
                    orig = waypts[0].location;
                    waypts.splice(0, 1);
                    dest = waypts.pop().location;
                }
                else{
                    orig = waypts[0].location;
                    waypts.slice(0);

                    dest = orig;
                }

                directionsService.route({
                    origin: orig,
                    destination: dest,
                    waypoints: waypts,
                    optimizeWaypoints: false,
                    travelMode: google.maps.TravelMode.WALKING
                }, function(response, status) {
                    if (status === google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(response);
                    } else {
                        window.alert('Directions request failed due to ' + status);
                    }
                });
            }

            for (var i=0; i<wayptscpy.length; i++)
            {
                var id = wayptscpy[i].id;
                var title = wayptscpy[i].title;
                var dateObj = new Date(wayptscpy[i].date_time);
                var date = dateObj.toLocaleDateString();

                FindLatLong(wayptscpy[i].location, displayPts, title, date, id, map);
            }


        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
        }
    });

}

function FindLatLong(address, callback, title, date, id, map)
{
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': address }, function (results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
            callback(results[0].geometry.location.lat(), results[0].geometry.location.lng(), map, title, date, id);
        }
    });
}

function displayPts(lat, long, map, title, date, id){

    var contentString = '<a class="link-map-stage" href="#stage'+id+'"><h4>'+title+'</h4><p>'+date+'</p></a>';

    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    var marker = new google.maps.Marker({
        position: {
            lat: lat,
            lng: long
        },
        map: map
    });

    infowindow.open(map, marker);

    marker.addListener('click', function() {
        infowindow.open(map, marker);
    });
}

