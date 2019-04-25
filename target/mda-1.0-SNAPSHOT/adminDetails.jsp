<%-- 
    Document   : adminData
    Created on : 06-abr-2019, 23:27:16
    Author     : Heckutoru
--%>

<%@page import="com.mycompany.mda.Details"%>
<%@page import="com.mycompany.mda.dbHandler"%>
<%@page import="java.util.ArrayList"%>
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
                <th>Route</th> 
                <th>Schedul</th>
                <th>Schedul Back</th>
                <th></th>
            </tr>
            <%              
                if(request.getParameter("line") != null){
                    String sql = dbHandler.deleteDetailsSQL(request.getParameter("line"));
                    dbHandler.getData(sql, false);
                }

                if(request.getParameter("noguagua") != null){
                    
                    String sql = null;
                    if(request.getParameter("status").equals("update")){
                        sql = dbHandler.updateSQL(
                                request.getParameter("noguagua"), 
                                request.getParameter("route"), 
                                request.getParameter("schedul"), 
                                request.getParameter("schedul_back"));
                    } else if(request.getParameter("status").equals("insert")) {
                        sql = dbHandler.insertSQL(
                                request.getParameter("noguagua"), 
                                request.getParameter("route"), 
                                request.getParameter("schedul"), 
                                request.getParameter("schedul_back"));
                    }
                    
                    if(sql != null){
                        dbHandler.getDetails(sql,false);
                    }
                }

                ArrayList<Details> detailsList = dbHandler.getDetails("SELECT * FROM details",true);
                for (Details result : detailsList) {
                    out.println("<tr><td>" + result.getLineNumber()+ "</td>");
                    out.println("<td>" + result.getRoute() + "</td>");
                    out.println("<td>" + result.getSchedul() + "</td>");
                    out.println("<td>" + result.getSchedul_back() + "</td>");
                    out.println("<td><a href=\"/MDA-master/addDetails.jsp?noguagua=" + result.getLineNumber() + 
                            "&route=" + result.getRoute()+ 
                            "&schedul=" + result.getSchedul() + 
                            "&schedul_back=" + result.getSchedul_back() + 
                            "&status=update\">Edit. </a>");
                    out.println("<a href=\"/MDA-master/adminDetails.jsp?line=" + result.getLineNumber() + "\"> Delete.</a></td></tr>");
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
