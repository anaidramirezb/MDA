package com.mycompany.mda;

import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Héctor Déniz Álvarez (Heckutoru)
 */
public class dbHandler {

    public static ArrayList<Buses> getData(String sql, boolean resultB) {
        Connection c = null;
        Statement stmt = null;
        ResultSet result = null;
        String output = "";
        ArrayList<Buses> busesList = new ArrayList<>();

        try {
            Class.forName("org.sqlite.JDBC");
            String dbLocation = "jdbc:sqlite:C:\\Users\\Heckutoru\\Documents\\NetBeansProjects\\MDA-master\\src\\main\\webapp\\mda.db";
            c = DriverManager.getConnection(dbLocation);
            c.setAutoCommit(false);

            stmt = c.createStatement();

            if (resultB) {
                result = stmt.executeQuery(sql);
                while (result.next()) {
                    Buses busStop = new Buses(result.getInt("line_number"));
                    busStop.setStopNumber(result.getInt("stop_number"));
                    busStop.setLatitude(result.getDouble("latitude"));
                    busStop.setLongitud(result.getDouble("longitud"));
                    busesList.add(busStop);
                }
            } else {
                stmt.executeUpdate(sql);
            }

            stmt.close();
            c.commit();
            c.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        return busesList;
    }

    public static String insertSQL(String line_number, String stop_number, String latitude, String longitud) {
        return "INSERT INTO buses (line_number,stop_number,latitude,longitud) "
                + "VALUES (\"" + line_number + "\",\"" + stop_number + "\",\"" + latitude + "\",\"" + longitud + "\");";
    }

    public static String updateSQL(String line_number, String stop_number, String latitude, String longitud) {
        return "update buses set latitude =\"" + latitude + "\", longitud = \"" + longitud + "\""
                + "where line_number = " + line_number + " and stop_number = \"" + stop_number + "\";";
    }

    public static String deleteSQL(String line_number, String stop_number) {
        return "delete from buses where line_number =\" " + line_number + "\" and stop_number = \""
                + stop_number + "\";";
    }

}