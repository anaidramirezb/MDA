<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.mda.Buses"%>
<%@page import="com.mycompany.mda.dbHandler"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="./styles/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
              crossorigin="anonymous">
        <title>Bus Finder</title>   
    </head>
    
    
    <body style="background-color: cadetblue;">
        <style>
            /* Set the size of the div element that contains the map */
            #map {
                /*height: 600px;  
                align-content: center; */
                  padding:25% 40%;
            }
        </style>
        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
        
         
         <div class= "row ">
        <div class= "col-md-12">
                <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-static-top">

                        <IMG SRC="styles/menu/GUAGUAS_GC.png" Width = 10% style="margin-left:30px">
                        <button title= "Mi ubicacion" type="button" class="btn btn-info img-ubi" onclick="getLocation()"></button>
                        <button title= "Parada mas cercana" type="button" class="btn btn-info img-stop" onclick="getCurrent()"></button>
                        <button title= "Mostrar guaguas" type="button" class="btn btn-info img-persona" onclick="getBus()" ></button>
                        <button title= "Tiempo a parada" type="button" class="btn btn-info img-signo" onclick="calculateAndDisplayRoute()"></button>   
                        <div id="resultado" class="res"> min </div>
                                   
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                          <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
                            <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Opciones
                              </a>
                              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="adminData.jsp">Listado Guaguas</a>
                                <a class="dropdown-item" href="addroutes.jsp">Agregar Ruta</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Información</a>
                                  <a class="dropdown-item" href="addDetails.jsp">Agregar Detalles</a>
                              </div>
                            </li>
                          </ul>
                        </div>   
                      </nav>
        </div>
        </div>

        <div class="row row-height"> 
        <div class="col-md-2  col-sm-12 formato" >           
    

        <div class="scroll row-height">
        <a href="/MDA-master/index.jsp?line=316" class="list-group-item list-group-item-action bg-info border img-global">Linea 316</a>
        <a href="/MDA-master/index.jsp?line=303" class="list-group-item list-group-item-action bg-info border img-global">Linea 303</a>
        <a href="/MDA-master/index.jsp?line=38" class="list-group-item list-group-item-action bg-info border img-global">Linea 38</a>
        <a href="/MDA-master/index.jsp?line=327" class="list-group-item list-group-item-action bg-info border img-global">Linea 327</a>
        <a href="/MDA-master/index.jsp?line=302" class="list-group-item list-group-item-action bg-info border img-global">Linea 302</a>
        <a href="/MDA-master/index.jsp?line=101" class="list-group-item list-group-item-action bg-info border img-global">Linea 101</a>
        <a href="/MDA-master/index.jsp" class="list-group-item list-group-item-action bg-info border img-global"> VACIAR</a>

    
      </div>
      </div> 

      <div class="col-md-10 col-sm-12" >        
      <div id="map" ></div>  
      </div>          
      </div>
        
        <p id="demo"></p>

        
        <script>
 
            var coords = new Array();
            <%
                ArrayList<Buses> busList = null;
                int i = 0;
                if (request.getParameter("line") != null) {
                    busList = dbHandler.getData("SELECT * FROM buses WHERE line_number=\"" + request.getParameter("line") + "\"", true);
                } else {
                    busList = dbHandler.getData("SELECT * FROM buses", true);
                }

                for (Buses elem : busList) {
            %>coords[<%= i++%>] = [<%= elem.getLatitude()%>, <%= elem.getLongitud()%>];
            <%}%>

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
            <% if (request.getParameter("busLocation") == null) {
                    if (request.getParameter("line") != null) { %>
                    coords.forEach(function (each) {
                        showLocation(each[0], each[1]);
                    });
            <%}%>
            <% } else { %>
                    var randomLoc = Math.floor(Math.random() * coords.length);
                    showLocation(coords[randomLoc][0], coords[randomLoc][1]);
            <% }%>
                }

                function getLocation() {
                   
                    if (navigator.geolocation) {
                       navigator.geolocation.getCurrentPosition(showPosition);
                     } else {
                         x.innerHTML = "Geolocation is not supported by this browser.";
                     }
                }

                function getCurrent() {
                    if (navigator.geolocation) {
                        navigator.geolocation.getCurrentPosition(showClosest);
                        type: 'info'
                    } else {
                        x.innerHTML = "Geolocation is not supported by this browser.";
                    }
                }

                function getBus() {
                    if (navigator.geolocation) {
                        var rango = Math.floor((Math.random() * coords.length) + 1);
                        showBus(coords[rango][0],coords[rango][1]);
                        navigator.geolocation.getCurrentPosition(showBus);
                      
                    } else {
                        x.innerHTML = "Geolocation is not supported by this browser.";
                    }
                }


                function showClosest(position) {
                    var currentLatitude = Math.abs(position.coords.latitude);
                    var currentLongitude = Math.abs(position.coords.longitude);
                    var closerIndex = 0;
                    var closerLatitude = currentLatitude - Math.abs(coords[0][0]);
                    var closerLongitude = currentLongitude - Math.abs(coords[0][1]);
                    var closer = Math.sqrt(closerLatitude * closerLatitude + closerLongitude * closerLongitude);
                    for (var index = 1; index < coords.length; index++) {
                        var newCloserLatitude = currentLatitude - Math.abs(coords[index][0]);
                        var newCloserLongitude = currentLongitude - Math.abs(coords[index][1]);
                        var newCloser = Math.sqrt(newCloserLatitude * newCloserLatitude + newCloserLongitude * newCloserLongitude);
                        if (newCloser < closer) {
                            closer = newCloser;
                            closerIndex = index;
                        }
                    }
                    shownearLocation(coords[closerIndex][0], coords[closerIndex][1]);
                    return new google.maps.LatLng(coords[closerIndex][0], coords[closerIndex][1]);
                }

                function showPosition(position) {

                    //clearOverlays();
                    
                    var iconBase = 'styles/menu/UserP.png';
                    var uluru = {lat: position.coords.latitude, lng: position.coords.longitude};
                    var marker = new google.maps.Marker({position: uluru, map: map, icon: iconBase});
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

                function showLocation(latitude, longitude) {
                    var iconBase = 'http://maps.google.com/mapfiles/kml/pal4/icon57.png';
                    var uluru = {lat: latitude, lng: longitude};
                    var marker = new google.maps.Marker({position: uluru, map: map, icon: iconBase});
                    markersArray.push(marker);
                    marker.setMap(map);
                }

                  
                function showBus(latitude, longitude) {
                    var iconBase = 'styles/menu/BusP.png';
                    var uluru = {lat: latitude, lng: longitude};
                    var marker = new google.maps.Marker({position: uluru, map: map, icon: iconBase});
                    markersArray.push(marker);
                    marker.setMap(map);
                }
                  
                function shownearLocation(latitude, longitude) {
                    var iconBase = 'http://maps.google.com/mapfiles/kml/shapes/placemark_circle_highlight.png';
                    var uluru = {lat: latitude, lng: longitude};
                    var marker = new google.maps.Marker({position: uluru, map: map, icon: iconBase});
                    markersArray.push(marker);
                    marker.setMap(map);
                }


                
                function calculateAndDisplayRoute(){
                    if (navigator.geolocation) {
                        navigator.geolocation.getCurrentPosition(route);
                    } else {
                        x.innerHTML = "Geolocation is not supported by this browser.";
                    }
                }
                
                function route(dest) {
                    var directionsDisplay = new google.maps.DirectionsRenderer();// also, constructor can get "DirectionsRendererOptions" object
                    directionsDisplay.setMap(map); // map should be already initialized.

                    var request = {
                        origin : new google.maps.LatLng(dest.coords.latitude,dest.coords.longitude ),
                        destination : new google.maps.LatLng(28.108767,-15.415788),
                        travelMode : google.maps.TravelMode.TRANSIT,
                        transitOptions: {
                            departureTime: new Date()
                        }
                    };
                    var directionsService = new google.maps.DirectionsService(); 
                    directionsService.route(request, function(response, status) {
                        if (status == google.maps.DirectionsStatus.OK) {
                            directionsDisplay.setDirections(response);
                            // alert(response.routes[0].legs[0].duration.text);
                             texto = response.routes[0].legs[0].duration.text;
                            document.getElementById('resultado').innerHTML = texto;
                        }
                    });
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
