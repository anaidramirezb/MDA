<%-- 
    Document   : addroutes
    Created on : Apr 1, 2019, 3:28:26 AM
    Author     : xoana
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Scanner"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>   
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
        <link rel="stylesheet" href="./styles/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar paradas</title>
    </head>
    
    
    
    
    <body style="background-color: cadetblue;">
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>


        <header class="row form-1">
            <div class="col-md-2">
               <IMG SRC="styles/menu/GUAGUAS_GC.png" Width = 100%>
            </div>
            <div class="col-md-10">
              <h2> Agregado de Rutas</h2>
            </div>
                 
        </header>
        
        
        <form action="/MDA-master/adminData.jsp" method="GET">

            <div class="form-2">
            <%
            String guagua = request.getParameter("noguagua");
            String paradastxt = request.getParameter("noparada");
            String status = request.getParameter("status");
            String longitud = request.getParameter("longitud");
            String latitud = request.getParameter("latitud");
            
            if (guagua != null) {
                out.println("Ingresar el numero de linea:  <input type=\"text\" name=\"noguagua\" value=\"" + guagua + "\" > </br>");
            } else {
                out.println("Ingresar el numero de linea:  <input type=\"text\" name=\"noguagua\"> </br>");
            }
            
            if (paradastxt != null) {
                out.println("Ingresar el numero de parada:  <input type=\"text\" name=\"noparada\" value=\"" + paradastxt + "\"> </br>");
            } else {
                out.println("Ingresar el numero de parada:  <input type=\"text\" name=\"noparada\" > </br>");
            }

            if (latitud != null) {
                out.println("Latitud:   <input type=\"text\" name=\"latitud\" value=\"" + latitud + "\"> </br>");
            } else {
                out.println("Latitud:   <input type=\"text\" name=\"latitud\" > </br>");
            }

            if (longitud != null) {
                out.println("Longitud:  <input type=\"text\" name=\"longitud\" value=\"" + longitud + "\"> </br>");
            } else {
                out.println("Longitud:  <input type=\"text\" name=\"longitud\" > </br>");
            }
            
            if(status != null){
                out.print("<input type=\"hidden\" name=\"status\" value=\"" + status + "\">");
            } else {
                out.print("<input type=\"hidden\" name=\"status\" value=\"insert\">"); 
            }
        %>   
    </div>     

      <div style="background-color:whitesmoke;
           padding: 30px;">
            <button type="submit" value= "Guardar" class="btn btn-info" 
            style="float:left;
            margin-right: 20px; 
            margin-left: 43%;
            margin-top: 10px;">Guardar</button>
            
            <a href="index.jsp" class="btn btn-info" style="margin-top:10px;">Volver</a>

        </div> 
    </form>
       
    
    </body>
</html>

