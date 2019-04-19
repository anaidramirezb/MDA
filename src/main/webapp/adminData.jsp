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
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
            crossorigin="anonymous">
            <link rel="stylesheet" href="./styles/style.css">
         
       

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>


        <table class="table ">
            <tr >
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
        <!-- <form action="/MDA-master/addroutes.jsp" method="GET">
            <input type="hidden" name="status" value="insert"> 
            <input type="submit" value= "Crer nuevo">
        </form> -->

        <div style="margin-left: 42%; margin-bottom: 50px;">
            <a href="addroutes.jsp" class="btn btn-info" style="margin-top:10px;">Nuevo registro</a>  
            <a href="index.jsp" class="btn btn-info" style="margin-top:10px; margin-left: 30px">Volver</a>
        </div> 
    </body>
</html>
