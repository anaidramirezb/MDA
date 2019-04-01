<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.mda.Buses"%>
<%@page import="com.mycompany.mda.dbHandler"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="./styles/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
              crossorigin="anonymous">
        <style>
            /* Set the size of the div element that contains the map */
            #map {
                height: 600px;  
                align-content: center;
            }
        </style>
    </head>
    <body>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>

        <!-- Code for side buttons -->
        <div class="container-fluid">
            <div class="row">
                <div class=" header dropdown col-2">
                    <h1 class="  menu-header img-header" aria-haspopup="true" aria-expanded="false">
                        LINEAS GRAN CANARIA
                    </h1>
                    <div class="row">
                        <button onclick="window.location = '/MDA-master/index.jsp?line=316';" class="btn btn-primary btn-lg btn-block img-global">Ruta Linea 316 </button>
                    </div>
                    <div class="row">
                        <button onclick="window.location = '/MDA-master/index.jsp?line=316&busLocation';" class="btn btn-primary btn-lg btn-block img-global">Localizacion Linea 316</button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-global">Ruta Linea 327 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-global">Localizacion Linea 327 </button>
                    </div>

                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Ruta Linea 1 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Localizacion Linea 1 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Ruta Linea 4 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Localizacion Linea 4 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Ruta Linea 5 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Localizacion Linea 5 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Ruta Linea 12 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Localizacion Linea 12 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Ruta Linea 25 </button>
                    </div>
                    <div class="row">
                        <button type="button" class="btn btn-primary btn-lg btn-block img-LPA">Localizacion Linea 25 </button>
                    </div>
                </div>
                <div class="col-8">
                    <div class="row">
                        <div class="col">
                            <div id="map">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button onclick="getLocation()">Get current location.</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <p id="demo"></p>
        <%
            if (request.getParameter("line") != null) {
        %>
        <script>

            var coords = new Array();
            <%
                ArrayList<Buses> busList = dbHandler.getData("SELECT * FROM buses WHERE line_number=\"" + request.getParameter("line") + "\"",true);
                int i = 0;
                for (Buses elem : busList) {
            %>
            coords[<%= i++%>] = [<%= elem.getLatitude()%>, <%= elem.getLongitud()%>];
            <%
                }
            %>

        </script>
        <%
            }
        %>
        <script>
            var x = document.getElementById("demo");
            //var directionsService = new google.maps.DirectionsService();
            //var directionsDisplay = new google.maps.DirectionsRenderer();
            var markersArray = [];
            var map;

            // Initialize and add the map
            function initMap() {
                // The location of Uluru
                var uluru = {lat: 28.0731039, lng: -15.453665};
                // The map, centered at Uluru
                map = new google.maps.Map(
                        document.getElementById('map'), {zoom: 12, center: uluru});
                //directionsDisplay.setMap(map);
                <% if (request.getParameter("busLocation") == null) { %>
                    coords.forEach(function (each) {
                        showBus(each[0], each[1]);
                    });
                <% } else { %>
                    //showBus(28.099468,-15.459320);
                    var randomLoc = Math.floor(Math.random()*coords.length);
                    showBus(coords[randomLoc][0],coords[randomLoc][1]);
                <% }%>
            }

            function getLocation() {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(showPosition);
                } else {
                    x.innerHTML = "Geolocation is not supported by this browser.";
                }
            }

            function showPosition(position) {
                //clearOverlays();
                var uluru = {lat: position.coords.latitude, lng: position.coords.longitude};
                var marker = new google.maps.Marker({position: uluru, map: map});
                markersArray.push(marker);
                marker.setMap(map);
            }
            /*
             function showRoute(locations) {
             //clearOverlays();
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
             }*/

            function showBus(latitude, longitude) {
                //clearOverlays();
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