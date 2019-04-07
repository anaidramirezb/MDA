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
        <link rel="stylesheet" href="./styles/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar paradas</title>
    </head>
    <h1> Ingresar las coordenadas de las paradas</h1>
    <body>
        <form action="/MDA-master/adminData.jsp" method="GET">
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
                out.println("Latitud:  <input type=\"text\" name=\"latitud\" value=\"" + latitud + "\"> </br>");
            } else {
                out.println("Latitud:  <input type=\"text\" name=\"latitud\" > </br>");
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
            <input type="submit" value= "Guardar">
        </form>
    </body>
</html>

