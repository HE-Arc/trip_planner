
function initMap() {

    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer;
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 6,
        scrollwheel: false,
        center: {lat: 41.85, lng: -87.65} //todo center
    });
    directionsDisplay.setMap(map);

    calculateAndDisplayRoute(directionsService, directionsDisplay);
}


function calculateAndDisplayRoute(directionsService, directionsDisplay) {

    var waypts = [];

    $($('.article-lieu').get().reverse()).each(function (index, value) {
        var addr = $(this).text();

        waypts.push({
            location: addr,
            stopover: true
        });
    });

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