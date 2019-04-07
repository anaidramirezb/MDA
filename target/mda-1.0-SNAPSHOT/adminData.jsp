<%-- 
    Document   : adminData
    Created on : 06-abr-2019, 23:27:16
    Author     : Heckutoru
--%>

<%@page import="com.mycompany.mda.dbHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.mda.Buses"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table>
            <tr>
                <th>Line number</th>
                <th>Stop number</th> 
                <th>Latitude</th>
                <th>Longitud</th>
                <th></th>
            </tr>
            <%              
                if(request.getParameter("line") != null && request.getParameter("stop") != null){
                    String sql = dbHandler.deleteSQL(request.getParameter("line"), request.getParameter("stop"));
                    dbHandler.getData(sql, false);
                }

                if(request.getParameter("noguagua") != null 
                    && request.getParameter("noparada") != null
                    && request.getParameter("latitud") != null
                    && request.getParameter("longitud") != null){
                    
                    String sql = null;
                    if(request.getParameter("status").equals("update")){
                        sql = dbHandler.updateSQL(
                                request.getParameter("noguagua"), 
                                request.getParameter("noparada"), 
                                request.getParameter("latitud"), 
                                request.getParameter("longitud"));
                    } else if(request.getParameter("status").equals("insert")) {
                        sql = dbHandler.insertSQL(
                                request.getParameter("noguagua"), 
                                request.getParameter("noparada"), 
                                request.getParameter("latitud"), 
                                request.getParameter("longitud"));
                    }
                    
                    if(sql != null){
                        dbHandler.getData(sql,false);
                    }
                }

                ArrayList<Buses> busList = dbHandler.getData("SELECT * FROM buses",true);
                for (Buses result : busList) {
                    out.println("<tr><td>" + result.getLineNumber()+ "</td>");
                    out.println("<td>" + result.getStopNumber() + "</td>");
                    out.println("<td>" + result.getLatitude() + "</td>");
                    out.println("<td>" + result.getLongitud() + "</td>");
                    out.println("<td><a href=\"/MDA-master/addroutes.jsp?noguagua=" + result.getLineNumber() + 
                            "&noparada=" + result.getStopNumber() + 
                            "&latitud=" + result.getLatitude() + 
                            "&longitud=" + result.getLongitud() + 
                            "&status=update\">Edit. </a>");
                    out.println("<a href=\"/MDA-master/adminData.jsp?line=" + result.getLineNumber() + "&stop=" + result.getStopNumber() + "\"> Delete.</a></td></tr>");
                }
            %>
        </table>
        <form action="/MDA-master/addroutes.jsp" method="GET">
            <input type="hidden" name="status" value="insert"> 
            <input type="submit" value= "Crear nueva entrada.">
        </form>
    </body>
</html>
