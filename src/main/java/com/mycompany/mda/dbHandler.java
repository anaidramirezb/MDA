package com.mycompany.mda;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Héctor Déniz Álvarez (Heckutoru)
 */
public class dbHandler {

    private static ResultSet getData(String sql) {
        Connection c = null;
        Statement stmt = null;
        ResultSet result = null;
        String output = "";

        try {
            Class.forName("org.sqlite.JDBC");
            c = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\hecku\\OneDrive\\Documentos\\tracking.db");
            c.setAutoCommit(false);

            stmt = c.createStatement();
            result = stmt.executeQuery(sql);

            stmt.close();
            c.commit();
            c.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        return result;
    }
}
