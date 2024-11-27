package modele;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

import controleur.Categorie;
import controleur.Ticket;
import controleur.User;

public class Modele {

    private static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/unisphere?useSSL=false&serverTimezone=UTC", "root", "");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error connecting to database: " + e.getMessage());
            return null;
        }
    }

    public static boolean authenticateUser(String email, String password) {
        String query = "SELECT mdp FROM user WHERE email = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, email);

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    String storedPassword = result.getString("mdp"); // Récupérer le mot de passe stocké
                    return storedPassword.equals(password); // Comparer directement avec le mot de passe en clair
                }
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
        }
        return false;
    }
    
    public static int getUserIdByEmail(String email) {
        String query = "SELECT id_user FROM user WHERE email = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, email);

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return result.getInt("id_user"); // Return the userId
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if no userId is found
    }


    public static ArrayList<Ticket> selectAllTickets() {
        ArrayList<Ticket> tickets = new ArrayList<>();
        String query = "SELECT id_ticket, date_creation, sujet, description, statut, user_id, categorie_id FROM POL_ticket";

        try (Connection connection = getConnection();
             Statement statement = connection.createStatement();
             ResultSet result = statement.executeQuery(query)) {

            while (result.next()) {
                int idTicket = result.getInt("id_ticket");
                Date dateCreation = result.getTimestamp("date_creation");
                String sujet = result.getString("sujet");
                String description = result.getString("description");
                String statut = result.getString("statut");
                int userId = result.getInt("user_id");
                Integer categorieId = result.getObject("categorie_id") != null ? result.getInt("categorie_id") : null;

                Ticket ticket = new Ticket(idTicket, dateCreation, sujet, description, statut, userId, categorieId);
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving tickets: " + e.getMessage());
        }
        return tickets;
    }

    public static void saveTicket(Ticket ticket) {
        String query = "INSERT INTO POL_ticket (date_creation, sujet, description, user_id, categorie_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setTimestamp(1, new Timestamp(ticket.getDateCreation().getTime()));
            statement.setString(2, ticket.getSujet());
            statement.setString(3, ticket.getDescription());
            statement.setInt(4, ticket.getUserId());

            if (ticket.getCategorieId() != null) {
                statement.setInt(5, ticket.getCategorieId());
            } else {
                statement.setNull(5, java.sql.Types.INTEGER);
            }

            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error saving ticket: " + e.getMessage());
        }
    }

    public static ArrayList<Categorie> selectAllCategories() {
        ArrayList<Categorie> categories = new ArrayList<>();
        String query = "SELECT id_categorie, nom FROM POL_categorie";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet result = statement.executeQuery()) {

            while (result.next()) {
                int idCategorie = result.getInt("id_categorie");
                String nom = result.getString("nom");

                Categorie categorie = new Categorie(idCategorie, nom);
                categories.add(categorie);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving categories: " + e.getMessage());
        }
        return categories;
    }

    public static User getUserById(int idUser) {
        String query = "SELECT * FROM user WHERE id_user = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, idUser);

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return new User(
                        result.getInt("id_user"),
                        result.getString("nom"),
                        result.getString("prenom"),
                        result.getString("etablissement"),
                        result.getString("email"),
                        result.getString("mdp"),
                        result.getInt("role_id")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user: " + e.getMessage());
        }
        return null;
    }

    public static ArrayList<User> getAllUsers() {
        ArrayList<User> users = new ArrayList<>();
        String query = "SELECT * FROM user";

        try (Connection connection = getConnection();
             Statement statement = connection.createStatement();
             ResultSet result = statement.executeQuery(query)) {

            while (result.next()) {
                User user = new User(
                    result.getInt("id_user"),
                    result.getString("nom"),
                    result.getString("prenom"),
                    result.getString("etablissement"),
                    result.getString("email"),
                    result.getString("mdp"),
                    result.getInt("role_id")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving users: " + e.getMessage());
        }
        return users;
    }

    public static void saveUser(User user) {
        String query = "INSERT INTO user (nom, prenom, etablissement, email, mdp, role_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, user.getNom());
            statement.setString(2, user.getPrenom());
            statement.setString(3, user.getEtablissement());
            statement.setString(4, user.getEmail());
            statement.setString(5, user.getMdp());
            statement.setInt(6, user.getRoleId());

            statement.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error saving user: " + e.getMessage());
        }
    }
}
