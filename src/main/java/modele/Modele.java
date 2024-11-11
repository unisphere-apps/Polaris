package modele;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import controleur.Ticket;

public class Modele {

    // Method to establish a new connection each time
    private static Connection getConnection() {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish the connection
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/unisphere?useSSL=false&serverTimezone=UTC", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<Ticket> selectAllTickets() {
        ArrayList<Ticket> lesTickets = new ArrayList<>();
        String query = "SELECT id_ticket, date_creation, sujet, description, statut, user_id, categorie_id FROM POL_ticket";

        // Try-with-resources to ensure resources are closed properly
        try (Connection connexion = getConnection();
             Statement statement = connexion.createStatement();
             ResultSet resultat = statement.executeQuery(query)) {

            while (resultat.next()) {
                int idTicket = resultat.getInt("id_ticket");
                Date dateCreation = resultat.getTimestamp("date_creation");
                String sujet = resultat.getString("sujet");
                String description = resultat.getString("description");
                String statut = resultat.getString("statut");
                int userId = resultat.getInt("user_id");
                Integer categorieId = resultat.getObject("categorie_id") != null ? resultat.getInt("categorie_id") : null;

                Ticket unTicket = new Ticket(idTicket, dateCreation, sujet, description, statut, userId, categorieId);
                lesTickets.add(unTicket);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lesTickets;
    }
}
