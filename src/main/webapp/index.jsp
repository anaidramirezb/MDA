<!DOCTYPE html>
<html>
    <head>
        <style>
            /* Set the size of the div element that contains the map */
            #map {
                height: 400px;  /* The height is 400 pixels */
                width: 100%;  /* The width is the width of the web page */
            }
        </style>
    </head>
    <body>
        <h3>My Google Maps Demo</h3>
        <!--The div element for the map -->
        <div id="map"></div>

        <button onclick="getLocation()">Get current location.</button>

        <p id="demo"></p>

        <script>
            var x = document.getElementById("demo");
            var directionsService = new google.maps.DirectionsService();
            var directionsDisplay = new google.maps.DirectionsRenderer();
            var markersArray = [];
            var map;

            var request = {
                travelMode: google.maps.TravelMode.Transit
            };

            // Initialize and add the map
            function initMap() {
                // The location of Uluru
                var uluru = {lat: 28.0731039, lng: -15.453665};
                // The map, centered at Uluru
                map = new google.maps.Map(
                        document.getElementById('map'), {zoom: 12, center: uluru});
                directionsDisplay.setMap(map);
            }

            function getLocation() {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(showPosition);
                } else {
                    x.innerHTML = "Geolocation is not supported by this browser.";
                }
            }

            function showPosition(position) {
                clearOverlays();
                var uluru = {lat: position.coords.latitude, lng: position.coords.longitude};
                var marker = new google.maps.Marker({position: uluru, map: map});
                markersArray.push(marker);
                marker.setMap(map);
            }

            function showRoute(locations) {
                clearOverlays();
                for (i = 0; i < locations.length; i++) {
                    //editar uluru para que pille coordenadas de locations
                    var uluru = {lat: position.coords.latitude, lng: position.coords.longitude};
                    var marker = new google.maps.Marker({position: uluru, map: map});
                    markersArray.push(marker);
                    marker.setMap(map);
                    if (i == 0)
                        request.origin = marker.getPosition();
                    else if (i == locations.length - 1)
                        request.destination = marker.getPosition();
                    else {
                        if (!request.waypoints)
                            request.waypoints = [];
                        request.waypoints.push({
                            location: marker.getPosition(),
                            stopover: true
                        });
                    }

                    directionsService.route(request, function (result, status) {
                        if (status == google.maps.DirectionsStatus.OK) {
                            directionsDisplay.setDirections(result);
                        }
                    });
                }
            }

            function showBus(latitude,longitude) {
                clearOverlays();
                var uluru = {lat: latitude, lng: longitude};
                var marker = new google.maps.Marker({position: uluru, map: map});
                markersArray.push(marker);
                marker.setMap(map);
            }
            
            function clearOverlays() {
                for (var i = 0; i < markersArray.length; i++) {
                    markersArray[i].setMap(null);
                    markersArray.pop(markersArray[i]);
                }
                markersArray.length = 0;
            }
        </script>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCejBxTXzvaX97aZIJo_R1AQmNkm7oDvPA &callback=initMap">
        </script>
    </body>
</html>