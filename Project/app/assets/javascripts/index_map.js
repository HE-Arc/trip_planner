function initGeoIndex() {
    var geocoder = new google.maps.Geocoder();

    //initialize maps
    initMapIndex();
}


function initMapIndex() {

    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer;



    var map = new google.maps.Map(document.getElementById('index-map'), {
        zoom: 6,
        scrollwheel: false,
        center: {lat: 41.85, lng: -87.65},
        disableDefaultUI: true
    });
    directionsDisplay.setMap(map);


    //Get trip

    $.ajax({
        type: 'GET',
        url: '/randtrip',
        success: function (data, textStatus, jqXHR) {
            $('#tripName').text(data.trip.title);
            $('#tripUserName').text(data.user.email);
            $('#tripLocation').text(data.trip.main_country);

            var dateStart = new Date(data.trip.date_start);
            var dateEnd = new Date(data.trip.date_end);

            $('#tripDate').text(dateStart.toLocaleDateString() + " - " + dateEnd.toLocaleDateString());


            $('#tripDiscoverButton').attr("href", "/trips/"+data.trip.id);

            calculateAndDisplayRouteIndex(directionsService, directionsDisplay, data.stages);

        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
        }
    });

}


function calculateAndDisplayRouteIndex(directionsService, directionsDisplay, stages) {

    var waypts = [];


    for(var i=0; i<stages.length; i++)
    {
        var addr = stages[i].adress;

        waypts.push({
            location: addr,
            stopover: true
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
            travelMode: google.maps.TravelMode.DRIVING
        }, function(response, status) {
            if (status === google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
            } else {
                window.alert('Directions request failed due to ' + status);
            }
        });

    }

}