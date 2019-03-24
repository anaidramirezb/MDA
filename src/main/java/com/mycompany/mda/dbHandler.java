package com.mycompany.mda;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Héctor Déniz Álvarez (Heckutoru)
 */
public class dbHandler {

    public static ArrayList<Buses> getData(String sql) {
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
            result = stmt.executeQuery(sql);
            while (result.next()) {
                Buses busStop = new Buses(result.getInt("line_number"));
                busStop.setStopNumber(result.getInt("stop_number"));
                busStop.setLatitude(result.getDouble("latitude"));
                busStop.setLongitud(result.getDouble("longitud"));
                busesList.add(busStop);
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
}
